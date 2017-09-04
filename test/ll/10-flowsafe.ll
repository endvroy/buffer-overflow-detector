; ModuleID = '<stdin>'
source_filename = "c/10-flowsafe.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 !dbg !6 {
  %3 = alloca [20 x i32], align 16
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata i8** %1, i64 0, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata [20 x i32]* %3, metadata !18, metadata !14), !dbg !23
  %4 = bitcast [20 x i32]* %3 to i8*, !dbg !23
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 80, i32 16, i1 false), !dbg !23
  call void @llvm.dbg.value(metadata i32 1, i64 0, metadata !24, metadata !14), !dbg !25
  call void @llvm.dbg.value(metadata i32 2, i64 0, metadata !26, metadata !14), !dbg !27
  %5 = icmp ne i32 %0, 0, !dbg !28
  br i1 %5, label %6, label %9, !dbg !30

; <label>:6:                                      ; preds = %2
  %7 = mul nsw i32 1, -2, !dbg !31
  call void @llvm.dbg.value(metadata i32 %7, i64 0, metadata !24, metadata !14), !dbg !25
  %8 = add nsw i32 2, 2, !dbg !33
  call void @llvm.dbg.value(metadata i32 %8, i64 0, metadata !26, metadata !14), !dbg !27
  br label %12, !dbg !34

; <label>:9:                                      ; preds = %2
  %10 = mul nsw i32 1, 3, !dbg !35
  call void @llvm.dbg.value(metadata i32 %10, i64 0, metadata !24, metadata !14), !dbg !25
  %11 = sub nsw i32 2, 1, !dbg !37
  call void @llvm.dbg.value(metadata i32 %11, i64 0, metadata !26, metadata !14), !dbg !27
  br label %12

; <label>:12:                                     ; preds = %9, %6
  %.01 = phi i32 [ %7, %6 ], [ %10, %9 ]
  %.0 = phi i32 [ %8, %6 ], [ %11, %9 ]
  call void @llvm.dbg.value(metadata i32 %.0, i64 0, metadata !26, metadata !14), !dbg !27
  call void @llvm.dbg.value(metadata i32 %.01, i64 0, metadata !24, metadata !14), !dbg !25
  %13 = add nsw i32 10, %.01, !dbg !38
  %14 = add nsw i32 %13, %.0, !dbg !39
  call void @llvm.dbg.value(metadata i32 %14, i64 0, metadata !24, metadata !14), !dbg !25
  %15 = sext i32 %14 to i64, !dbg !40
  %16 = getelementptr inbounds [20 x i32], [20 x i32]* %3, i64 0, i64 %15, !dbg !40
  %17 = load i32, i32* %16, align 4, !dbg !40
  ret i32 %17, !dbg !41
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
!1 = !DIFile(filename: "c/10-flowsafe.c", directory: "/home/nick/teaching/886/overflower-template/test")
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
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 640, elements: !21)
!20 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!21 = !{!22}
!22 = !DISubrange(count: 20)
!23 = !DILocation(line: 4, column: 12, scope: !6)
!24 = !DILocalVariable(name: "x", scope: !6, file: !1, line: 8, type: !9)
!25 = !DILocation(line: 8, column: 7, scope: !6)
!26 = !DILocalVariable(name: "y", scope: !6, file: !1, line: 9, type: !9)
!27 = !DILocation(line: 9, column: 7, scope: !6)
!28 = !DILocation(line: 10, column: 7, scope: !29)
!29 = distinct !DILexicalBlock(scope: !6, file: !1, line: 10, column: 7)
!30 = !DILocation(line: 10, column: 7, scope: !6)
!31 = !DILocation(line: 11, column: 7, scope: !32)
!32 = distinct !DILexicalBlock(scope: !29, file: !1, line: 10, column: 13)
!33 = !DILocation(line: 12, column: 7, scope: !32)
!34 = !DILocation(line: 13, column: 3, scope: !32)
!35 = !DILocation(line: 14, column: 7, scope: !36)
!36 = distinct !DILexicalBlock(scope: !29, file: !1, line: 13, column: 10)
!37 = !DILocation(line: 15, column: 7, scope: !36)
!38 = !DILocation(line: 17, column: 10, scope: !6)
!39 = !DILocation(line: 17, column: 14, scope: !6)
!40 = !DILocation(line: 18, column: 10, scope: !6)
!41 = !DILocation(line: 18, column: 3, scope: !6)
