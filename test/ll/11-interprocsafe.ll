; ModuleID = '<stdin>'
source_filename = "c/11-interprocsafe.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @foo(i32, i32, i32) #0 !dbg !6 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !13, metadata !11), !dbg !14
  call void @llvm.dbg.value(metadata i32 %2, i64 0, metadata !15, metadata !11), !dbg !16
  %4 = icmp ne i32 %0, 0, !dbg !17
  br i1 %4, label %5, label %8, !dbg !19

; <label>:5:                                      ; preds = %3
  %6 = mul nsw i32 %1, -2, !dbg !20
  call void @llvm.dbg.value(metadata i32 %6, i64 0, metadata !13, metadata !11), !dbg !14
  %7 = add nsw i32 %2, 2, !dbg !22
  call void @llvm.dbg.value(metadata i32 %7, i64 0, metadata !15, metadata !11), !dbg !16
  br label %11, !dbg !23

; <label>:8:                                      ; preds = %3
  %9 = mul nsw i32 %1, 3, !dbg !24
  call void @llvm.dbg.value(metadata i32 %9, i64 0, metadata !13, metadata !11), !dbg !14
  %10 = sub nsw i32 %2, 1, !dbg !26
  call void @llvm.dbg.value(metadata i32 %10, i64 0, metadata !15, metadata !11), !dbg !16
  br label %11

; <label>:11:                                     ; preds = %8, %5
  %.01 = phi i32 [ %6, %5 ], [ %9, %8 ]
  %.0 = phi i32 [ %7, %5 ], [ %10, %8 ]
  call void @llvm.dbg.value(metadata i32 %.0, i64 0, metadata !15, metadata !11), !dbg !16
  call void @llvm.dbg.value(metadata i32 %.01, i64 0, metadata !13, metadata !11), !dbg !14
  %12 = add nsw i32 10, %.01, !dbg !27
  %13 = add nsw i32 %12, %.0, !dbg !28
  ret i32 %13, !dbg !29
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 !dbg !30 {
  %3 = alloca [20 x i32], align 16
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !36, metadata !11), !dbg !37
  call void @llvm.dbg.value(metadata i8** %1, i64 0, metadata !38, metadata !11), !dbg !39
  call void @llvm.dbg.declare(metadata [20 x i32]* %3, metadata !40, metadata !11), !dbg !45
  %4 = bitcast [20 x i32]* %3 to i8*, !dbg !45
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 80, i32 16, i1 false), !dbg !45
  call void @llvm.dbg.value(metadata i32 1, i64 0, metadata !46, metadata !11), !dbg !47
  call void @llvm.dbg.value(metadata i32 2, i64 0, metadata !48, metadata !11), !dbg !49
  %5 = call i32 @foo(i32 %0, i32 1, i32 2), !dbg !50
  call void @llvm.dbg.value(metadata i32 %5, i64 0, metadata !46, metadata !11), !dbg !47
  %6 = sext i32 %5 to i64, !dbg !51
  %7 = getelementptr inbounds [20 x i32], [20 x i32]* %3, i64 0, i64 %6, !dbg !51
  %8 = load i32, i32* %7, align 4, !dbg !51
  ret i32 %8, !dbg !52
}

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
!1 = !DIFile(filename: "c/11-interprocsafe.c", directory: "/home/nick/teaching/886/overflower-template/test")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!6 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 4, type: !7, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9, !9, !9, !9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "c", arg: 1, scope: !6, file: !1, line: 4, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 4, column: 9, scope: !6)
!13 = !DILocalVariable(name: "a", arg: 2, scope: !6, file: !1, line: 4, type: !9)
!14 = !DILocation(line: 4, column: 16, scope: !6)
!15 = !DILocalVariable(name: "b", arg: 3, scope: !6, file: !1, line: 4, type: !9)
!16 = !DILocation(line: 4, column: 23, scope: !6)
!17 = !DILocation(line: 5, column: 7, scope: !18)
!18 = distinct !DILexicalBlock(scope: !6, file: !1, line: 5, column: 7)
!19 = !DILocation(line: 5, column: 7, scope: !6)
!20 = !DILocation(line: 6, column: 7, scope: !21)
!21 = distinct !DILexicalBlock(scope: !18, file: !1, line: 5, column: 10)
!22 = !DILocation(line: 7, column: 7, scope: !21)
!23 = !DILocation(line: 8, column: 3, scope: !21)
!24 = !DILocation(line: 9, column: 7, scope: !25)
!25 = distinct !DILexicalBlock(scope: !18, file: !1, line: 8, column: 10)
!26 = !DILocation(line: 10, column: 7, scope: !25)
!27 = !DILocation(line: 12, column: 13, scope: !6)
!28 = !DILocation(line: 12, column: 17, scope: !6)
!29 = !DILocation(line: 12, column: 3, scope: !6)
!30 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !31, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{!9, !9, !33}
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!35 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!36 = !DILocalVariable(name: "argc", arg: 1, scope: !30, file: !1, line: 17, type: !9)
!37 = !DILocation(line: 17, column: 10, scope: !30)
!38 = !DILocalVariable(name: "argv", arg: 2, scope: !30, file: !1, line: 17, type: !33)
!39 = !DILocation(line: 17, column: 23, scope: !30)
!40 = !DILocalVariable(name: "buffer", scope: !30, file: !1, line: 18, type: !41)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 640, elements: !43)
!42 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!43 = !{!44}
!44 = !DISubrange(count: 20)
!45 = !DILocation(line: 18, column: 12, scope: !30)
!46 = !DILocalVariable(name: "x", scope: !30, file: !1, line: 22, type: !9)
!47 = !DILocation(line: 22, column: 7, scope: !30)
!48 = !DILocalVariable(name: "y", scope: !30, file: !1, line: 23, type: !9)
!49 = !DILocation(line: 23, column: 7, scope: !30)
!50 = !DILocation(line: 24, column: 7, scope: !30)
!51 = !DILocation(line: 25, column: 10, scope: !30)
!52 = !DILocation(line: 25, column: 3, scope: !30)
