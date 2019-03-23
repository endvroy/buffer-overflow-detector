Detecting potential buffer overflows with dataflow analysis.
It involves computing the possible ranges of values for variables and using these ranges to identify potential buffer overflows.
The project is implemented in LLVM.

# Building the tool
1. Create a new directory for building.

        mkdir overflowerbuild

2. Change into the new directory.

        cd overflowerbuild

3. Run CMake with the path to the LLVM source.

        cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=True \
            -DLLVM_DIR=</path/to/LLVM/build>/lib/cmake/llvm/ ../overflower-template

4. Run make inside the build directory:

        make

The built tool called `bin/overflower`.

# Running the tool

First suppose that you have a program compiled to bitcode:

    clang -g -c -emit-llvm ../overflower-template/test/c/01-charbuffer.c -o 01.bc

Running the overflow analyzer:

    bin/overflower 01.bc

Running the buffer overflow detector as above should print the results in CSV format, where the meaning of each column is:

    <Context>, <Function of access>, <Line of access>, <Size of buffer>, <Possible range for access>

