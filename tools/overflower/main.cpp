
#include "llvm/ADT/APSInt.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/PrettyStackTrace.h"
#include "llvm/Support/Signals.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

#include <bitset>
#include <memory>
#include <string>

#include "DataflowAnalysis.h"


using namespace llvm;
using std::string;
using std::unique_ptr;


static cl::OptionCategory overflowerCategory{"overflower options"};

static cl::opt<string> inPath{cl::Positional,
                              cl::desc{"<Module to analyze>"},
                              cl::value_desc{"bitcode filename"},
                              cl::init(""),
                              cl::Required,
                              cl::cat{overflowerCategory}};


// Implement your analysis here.

enum class PossibleRangeValues {
    unknown,
    constant,
    infinity
};

struct RangeValue {
    PossibleRangeValues kind;
    llvm::ConstantInt *lvalue, *rvalue;

    RangeValue() : kind(PossibleRangeValues::unknown),
                   lvalue(nullptr),
                   rvalue(nullptr) {}


    bool isUnknown() const {
        return kind == PossibleRangeValues::unknown;
    }

    bool isInfinity() const {
        return kind == PossibleRangeValues::infinity;
    }

    bool isConstant() const {
        return kind == PossibleRangeValues::constant;
    }

    RangeValue
    operator|(const RangeValue &other) const {
        RangeValue r;
        if (isUnknown() || other.isUnknown()) {
            if (isUnknown()) {
                return other;
            }
            else {
                return *this;
            }
        }
        else if (isInfinity() || other.isInfinity()) {
            r.kind = PossibleRangeValues::infinity;
            return r;
        }
        else {
            auto &selfL = lvalue->getValue();
            auto &selfR = rvalue->getValue();
            auto &otherL = (other.lvalue)->getValue();
            auto &otherR = (other.rvalue)->getValue();

            r.kind = PossibleRangeValues::constant;
            if (selfL.slt(otherL)) {
                r.lvalue = lvalue;
            }
            else {
                r.lvalue = other.lvalue;
            }

            if (selfR.sgt(otherR)) {
                r.rvalue = rvalue;
            }
            else {
                r.rvalue = other.rvalue;
            }
            return r;
        }
    }

    bool
    operator==(const RangeValue &other) const {
        if (kind == PossibleRangeValues::constant &&
            other.kind == PossibleRangeValues::constant) {
            auto &selfL = lvalue->getValue();
            auto &selfR = rvalue->getValue();
            auto &otherL = (other.lvalue)->getValue();
            auto &otherR = (other.rvalue)->getValue();
            return selfL == otherL && selfR == otherR;
        }
        else {
            return kind == other.kind;
        }
    }

};

RangeValue makeRange(LLVMContext &context, APInt &left, APInt &right) {
    RangeValue r;
    r.kind = PossibleRangeValues::constant;
    r.lvalue = ConstantInt::get(context, left);
    r.rvalue = ConstantInt::get(context, right);
    return r;
}

RangeValue infRange() {
    RangeValue r;
    r.kind = PossibleRangeValues::infinity;
    return r;
}

using RangeState  = analysis::AbstractState<RangeValue>;
using RangeResult = analysis::DataflowResult<RangeValue>;

class RangeMeet : public analysis::Meet<RangeValue, RangeMeet> {
public:
    RangeValue
    meetPair(RangeValue &s1, RangeValue &s2) const {
        return s1 | s2;
    }
};

class RangeTransfer {
public:
    RangeValue getRangeFor(llvm::Value *v, RangeState &state) const {
        if (auto *constant = llvm::dyn_cast<llvm::ConstantInt>(v)) {
            RangeValue r;
            r.kind = PossibleRangeValues::constant;
            r.lvalue = r.rvalue = constant;
            return r;
        }
        return state[v];
    }

    RangeValue evaluateBinOP(llvm::BinaryOperator &binOp,
                             RangeState &state) const {
        auto *op1 = binOp.getOperand(0);
        auto *op2 = binOp.getOperand(1);
        auto range1 = getRangeFor(op1, state);
        auto range2 = getRangeFor(op2, state);

        if (range1.isConstant() && range2.isConstant()) {
//            auto &layout = binOp.getModule()->getDataLayout();
            auto l1 = range1.lvalue->getValue();
            auto r1 = range1.rvalue->getValue();
            auto l2 = range2.lvalue->getValue();
            auto r2 = range2.rvalue->getValue();

            auto &context = (range1.lvalue)->getContext();
            auto opcode = binOp.getOpcode();

            if (opcode == Instruction::Add) {
                bool ofl, ofr;
                auto l = l1.sadd_ov(l2, ofl);
                auto r = r1.sadd_ov(r2, ofr);
                if (ofl || ofr) {
                    return infRange();
                }
                else {
                    return makeRange(context, l, r);
                }
            }
            else if (opcode == Instruction::Sub) {
                bool ofl, ofr;
                auto l = l1.ssub_ov(r2, ofl);
                auto r = r1.ssub_ov(l2, ofr);
                if (ofl || ofr) {
                    return infRange();
                }
                else {
                    return makeRange(context, l, r);
                }
            }
            else if (opcode == Instruction::Mul) {
                SmallVector<APInt, 4> candidates;
                bool ofFlags[4];
                candidates.push_back(l1.smul_ov(l2, ofFlags[0]));
                candidates.push_back(l1.smul_ov(r2, ofFlags[1]));
                candidates.push_back(r1.smul_ov(l2, ofFlags[2]));
                candidates.push_back(r1.smul_ov(r2, ofFlags[3]));

                for (auto of:ofFlags) {
                    if (of) {
                        return infRange();
                    }
                }

                auto max = candidates[0];
                for (auto &x : candidates) {
                    if (x.sgt(max)) {
                        max = x;
                    }
                }

                auto min = candidates[0];
                for (auto &x : candidates) {
                    if (x.slt(min)) {
                        min = x;
                    }
                }
                return makeRange(context, min, max);
            }
            else if (opcode == Instruction::SDiv) {
                // todo: fill in
                return infRange();
            }
            else {
                // todo: fill in
                return infRange();
            }
        }
        else if (range1.isInfinity() || range2.isInfinity()) {
            RangeValue r;
            r.kind = PossibleRangeValues::infinity;
            return r;
        }
        else {
            RangeValue r;
            return r;
        }
    }

    RangeValue evaluateCast(llvm::CastInst &castOp, RangeState &state) const {
        auto *op = castOp.getOperand(0);
        auto value = getRangeFor(op, state);

        if (value.isConstant()) {
            auto &layout = castOp.getModule()->getDataLayout();
            auto x = ConstantFoldCastOperand(castOp.getOpcode(), value.lvalue,
                                             castOp.getDestTy(), layout);
            auto y = ConstantFoldCastOperand(castOp.getOpcode(), value.rvalue,
                                             castOp.getDestTy(), layout);
            if (llvm::isa<llvm::ConstantExpr>(x) || llvm::isa<llvm::ConstantExpr>(y)) {
                return infRange();
            }
            else {
                RangeValue r;
                auto *cix = dyn_cast<ConstantInt>(x);
                auto *ciy = dyn_cast<ConstantInt>(y);
                r.kind = PossibleRangeValues::constant;
                r.lvalue = cix;
                r.rvalue = ciy;
                return r;
            }
        }
        else {
            RangeValue r;
            r.kind = value.kind;
            return r;
        }
    }

    void
    operator()(llvm::Value &i, RangeState &state) {
        if (auto *constant = llvm::dyn_cast<llvm::ConstantInt>(&i)) {
            RangeValue r;
            r.kind = PossibleRangeValues::constant;
            r.lvalue = r.rvalue = constant;
            state[&i] = r;
        }
        else if (auto *binOp = llvm::dyn_cast<llvm::BinaryOperator>(&i)) {
            state[binOp] = evaluateBinOP(*binOp, state);
        }
        else if (auto *castOp = llvm::dyn_cast<llvm::CastInst>(&i)) {
            state[castOp] = evaluateCast(*castOp, state);
        }
        else {
            state[&i].kind = PossibleRangeValues::infinity;
        }
    }
};

void printRange(RangeValue &rangeValue) {
    if (rangeValue.isInfinity()) {
        outs() << "-inf:inf" << "\n";
    }
    else if (rangeValue.isUnknown()) {
        outs() << "unknown" << "\n";
    }
    else {
        outs() << rangeValue.lvalue->getValue() << ":" << rangeValue.rvalue->getValue() << "\n";
    }
}

void
printPotentialOf(RangeResult &rangeStates) {
    for (auto &valueStatePair : rangeStates) {
        auto *inst = llvm::dyn_cast<llvm::GetElementPtrInst>(valueStatePair.first);
        if (!inst) {
            continue;
        }

        auto &state = analysis::getIncomingState(rangeStates, *inst);
        auto index = inst->getOperand(2);
        auto constant = dyn_cast<Constant>(index);
        if (constant) {
            outs() << *constant << "\n";
        }
        else {
            //  todo: fill in
//            outs() << index;
            outs() << "index range\n";
            auto &rangeValue = state[index];
            printRange(rangeValue);
        }
//        llvm::outs() << "\n\n";
    }
}

void
debugPrint(RangeResult &rangeStates) {
    RangeState state;
    for (auto &valueStatePair : rangeStates) {
        auto *inst = llvm::dyn_cast<llvm::GetElementPtrInst>(valueStatePair.first);
        if (!inst) {
            continue;
        }
        state = analysis::getIncomingState(rangeStates, *inst);
    }

    for (auto &valueStatePair : rangeStates) {
        auto *inst = llvm::dyn_cast<llvm::Instruction>(valueStatePair.first);
        if (!inst) {
            continue;
        }
        outs() << *inst << '\n';
        auto range = state[inst];
        printRange(range);
        outs() << "==================\n";
    }
}

int main(int argc, char **argv) {
    // This boilerplate provides convenient stack traces and clean LLVM exit
    // handling. It also initializes the built in support for convenient
    // command line option handling.
    sys::PrintStackTraceOnErrorSignal(argv[0]);
    llvm::PrettyStackTraceProgram X(argc, argv);
    llvm_shutdown_obj shutdown;
    cl::HideUnrelatedOptions(overflowerCategory);
    cl::ParseCommandLineOptions(argc, argv);

    // Construct an IR file from the filename passed on the command line.
    SMDiagnostic err;
    LLVMContext context;
    unique_ptr<Module> module = parseIRFile(inPath.getValue(), err, context);

    if (!module.get()) {
        errs() << "Error reading bitcode file: " << inPath << "\n";
        err.print(argv[0], errs());
        return -1;
    }

    auto *mainFunction = module->getFunction("main");
    if (!mainFunction) {
        llvm::report_fatal_error("Unable to find main function.");
    }

    // Run your analysis and print your results here.

    using Value    = RangeValue;
    using Transfer = RangeTransfer;
    using Meet     = RangeMeet;
    using Analysis = analysis::ForwardDataflowAnalysis<Value, Transfer, Meet>;
    Analysis analysis{*module, mainFunction};
    auto results = analysis.computeForwardDataflow();

    for (auto & [context, contextResults] : results) {
        for (auto & [function, functionResults] : contextResults) {
            debugPrint(functionResults);
            printPotentialOf(functionResults);
        }
    }

    return 0;
}
