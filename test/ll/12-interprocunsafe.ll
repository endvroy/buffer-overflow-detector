; ModuleID = '<stdin>'
source_filename = "c/12-interprocunsafe.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @returnZero() #0 !dbg !6 {
  ret i32 0, !dbg !10
}

; Function Attrs: noinline nounwind uwtable
define i32 @returnFive() #0 !dbg !11 {
  ret i32 5, !dbg !12
}

; Function Attrs: noinline nounwind uwtable
define i32 @nested(i32) #0 !dbg !13 {
  %2 = alloca [4 x i32], align 16
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !16, metadata !17), !dbg !18
  call void @llvm.dbg.declare(metadata [4 x i32]* %2, metadata !19, metadata !17), !dbg !24
  %3 = bitcast [4 x i32]* %2 to i8*, !dbg !24
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 16, i32 16, i1 false), !dbg !24
  %4 = sext i32 %0 to i64, !dbg !25
  %5 = getelementptr inbounds [4 x i32], [4 x i32]* %2, i64 0, i64 %4, !dbg !25
  %6 = load i32, i32* %5, align 4, !dbg !25
  ret i32 %6, !dbg !26
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

; Function Attrs: noinline nounwind uwtable
define i32 @wrapper(i32) #0 !dbg !27 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !28, metadata !17), !dbg !29
  %2 = call i32 @nested(i32 %0), !dbg !30
  ret i32 %2, !dbg !31
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !38, metadata !17), !dbg !39
  call void @llvm.dbg.value(metadata i8** %1, i64 0, metadata !40, metadata !17), !dbg !41
  %3 = icmp ne i32 %0, 0, !dbg !42
  br i1 %3, label %4, label %6, !dbg !44

; <label>:4:                                      ; preds = %2
  %5 = call i32 @returnZero(), !dbg !45
  call void @llvm.dbg.value(metadata i32 %5, i64 0, metadata !47, metadata !17), !dbg !48
  br label %8, !dbg !49

; <label>:6:                                      ; preds = %2
  %7 = call i32 @returnFive(), !dbg !50
  call void @llvm.dbg.value(metadata i32 %7, i64 0, metadata !47, metadata !17), !dbg !48
  br label %8

; <label>:8:                                      ; preds = %6, %4
  %.0 = phi i32 [ %5, %4 ], [ %7, %6 ]
  call void @llvm.dbg.value(metadata i32 %.0, i64 0, metadata !47, metadata !17), !dbg !48
  %9 = call i32 @wrapper(i32 %.0), !dbg !52
  ret i32 %9, !dbg !53
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 4.0.0 (tags/RELEASE_400/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "c/12-interprocunsafe.c", directory: "/home/nick/teaching/886/overflower-template/test")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!6 = distinct !DISubprogram(name: "returnZero", scope: !1, file: !1, line: 3, type: !7, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocation(line: 4, column: 3, scope: !6)
!11 = distinct !DISubprogram(name: "returnFive", scope: !1, file: !1, line: 8, type: !7, isLocal: false, isDefinition: true, scopeLine: 8, isOptimized: false, unit: !0, variables: !2)
!12 = !DILocation(line: 9, column: 3, scope: !11)
!13 = distinct !DISubprogram(name: "nested", scope: !1, file: !1, line: 13, type: !14, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!14 = !DISubroutineType(types: !15)
!15 = !{!9, !9}
!16 = !DILocalVariable(name: "index", arg: 1, scope: !13, file: !1, line: 13, type: !9)
!17 = !DIExpression()
!18 = !DILocation(line: 13, column: 12, scope: !13)
!19 = !DILocalVariable(name: "buffer", scope: !13, file: !1, line: 14, type: !20)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 128, elements: !22)
!21 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!22 = !{!23}
!23 = !DISubrange(count: 4)
!24 = !DILocation(line: 14, column: 12, scope: !13)
!25 = !DILocation(line: 15, column: 10, scope: !13)
!26 = !DILocation(line: 15, column: 3, scope: !13)
!27 = distinct !DISubprogram(name: "wrapper", scope: !1, file: !1, line: 19, type: !14, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!28 = !DILocalVariable(name: "index", arg: 1, scope: !27, file: !1, line: 19, type: !9)
!29 = !DILocation(line: 19, column: 13, scope: !27)
!30 = !DILocation(line: 20, column: 10, scope: !27)
!31 = !DILocation(line: 20, column: 3, scope: !27)
!32 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 24, type: !33, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!9, !9, !35}
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !DILocalVariable(name: "argc", arg: 1, scope: !32, file: !1, line: 24, type: !9)
!39 = !DILocation(line: 24, column: 10, scope: !32)
!40 = !DILocalVariable(name: "argv", arg: 2, scope: !32, file: !1, line: 24, type: !35)
!41 = !DILocation(line: 24, column: 23, scope: !32)
!42 = !DILocation(line: 26, column: 7, scope: !43)
!43 = distinct !DILexicalBlock(scope: !32, file: !1, line: 26, column: 7)
!44 = !DILocation(line: 26, column: 7, scope: !32)
!45 = !DILocation(line: 27, column: 13, scope: !46)
!46 = distinct !DILexicalBlock(scope: !43, file: !1, line: 26, column: 13)
!47 = !DILocalVariable(name: "index", scope: !32, file: !1, line: 25, type: !9)
!48 = !DILocation(line: 25, column: 7, scope: !32)
!49 = !DILocation(line: 28, column: 3, scope: !46)
!50 = !DILocation(line: 29, column: 13, scope: !51)
!51 = distinct !DILexicalBlock(scope: !43, file: !1, line: 28, column: 10)
!52 = !DILocation(line: 31, column: 10, scope: !32)
!53 = !DILocation(line: 31, column: 3, scope: !32)
