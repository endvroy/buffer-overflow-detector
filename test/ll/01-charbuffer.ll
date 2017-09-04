; ModuleID = '<stdin>'
source_filename = "c/01-charbuffer.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 !dbg !6 {
  %3 = alloca [4 x i8], align 1
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata i8** %1, i64 0, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata [4 x i8]* %3, metadata !18, metadata !14), !dbg !22
  %4 = bitcast [4 x i8]* %3 to i8*, !dbg !22
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 4, i32 1, i1 false), !dbg !22
  %5 = getelementptr inbounds [4 x i8], [4 x i8]* %3, i64 0, i64 2, !dbg !23
  %6 = load i8, i8* %5, align 1, !dbg !23
  %7 = sext i8 %6 to i32, !dbg !23
  ret i32 %7, !dbg !24
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 4.0.0 (tags/RELEASE_400/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "c/01-charbuffer.c", directory: "/home/nick/teaching/886/overflower-template/test")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !7, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9, !9, !10}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DILocalVariable(name: "argc", arg: 1, scope: !6, file: !1, line: 3, type: !9)
!14 = !DIExpression()
!15 = !DILocation(line: 3, column: 10, scope: !6)
!16 = !DILocalVariable(name: "argv", arg: 2, scope: !6, file: !1, line: 3, type: !10)
!17 = !DILocation(line: 3, column: 23, scope: !6)
!18 = !DILocalVariable(name: "buffer", scope: !6, file: !1, line: 4, type: !19)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 32, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 4)
!22 = !DILocation(line: 4, column: 8, scope: !6)
!23 = !DILocation(line: 5, column: 10, scope: !6)
!24 = !DILocation(line: 5, column: 3, scope: !6)
