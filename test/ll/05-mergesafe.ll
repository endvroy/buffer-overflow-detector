; ModuleID = '<stdin>'
source_filename = "c/05-mergesafe.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 !dbg !6 {
  %3 = alloca [4 x i32], align 16
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata i8** %1, i64 0, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata [4 x i32]* %3, metadata !18, metadata !14), !dbg !23
  %4 = bitcast [4 x i32]* %3 to i8*, !dbg !23
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 16, i32 16, i1 false), !dbg !23
  %5 = icmp ne i32 %0, 0, !dbg !24
  br i1 %5, label %6, label %7, !dbg !26

; <label>:6:                                      ; preds = %2
  call void @llvm.dbg.value(metadata i32 0, i64 0, metadata !27, metadata !14), !dbg !28
  br label %8, !dbg !29

; <label>:7:                                      ; preds = %2
  call void @llvm.dbg.value(metadata i32 3, i64 0, metadata !27, metadata !14), !dbg !28
  br label %8

; <label>:8:                                      ; preds = %7, %6
  %.0 = phi i32 [ 0, %6 ], [ 3, %7 ]
  call void @llvm.dbg.value(metadata i32 %.0, i64 0, metadata !27, metadata !14), !dbg !28
  %9 = zext i32 %.0 to i64, !dbg !31
  %10 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 %9, !dbg !31
  %11 = load i32, i32* %10, align 4, !dbg !31
  ret i32 %11, !dbg !32
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
!1 = !DIFile(filename: "c/05-mergesafe.c", directory: "/home/nick/teaching/886/overflower-template/test")
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
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 128, elements: !21)
!20 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!21 = !{!22}
!22 = !DISubrange(count: 4)
!23 = !DILocation(line: 4, column: 12, scope: !6)
!24 = !DILocation(line: 6, column: 7, scope: !25)
!25 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 7)
!26 = !DILocation(line: 6, column: 7, scope: !6)
!27 = !DILocalVariable(name: "index", scope: !6, file: !1, line: 5, type: !20)
!28 = !DILocation(line: 5, column: 12, scope: !6)
!29 = !DILocation(line: 8, column: 3, scope: !30)
!30 = distinct !DILexicalBlock(scope: !25, file: !1, line: 6, column: 13)
!31 = !DILocation(line: 11, column: 10, scope: !6)
!32 = !DILocation(line: 11, column: 3, scope: !6)
