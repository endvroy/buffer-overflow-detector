; ModuleID = '<stdin>'
source_filename = "c/07-loopsafe.c"
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
  call void @llvm.dbg.value(metadata i16 0, i64 0, metadata !24, metadata !14), !dbg !26
  call void @llvm.dbg.value(metadata i16 0, i64 0, metadata !27, metadata !14), !dbg !29
  br label %5, !dbg !30

; <label>:5:                                      ; preds = %15, %2
  %.01 = phi i16 [ 0, %2 ], [ %14, %15 ]
  %.0 = phi i16 [ 0, %2 ], [ %16, %15 ]
  call void @llvm.dbg.value(metadata i16 %.0, i64 0, metadata !27, metadata !14), !dbg !29
  call void @llvm.dbg.value(metadata i16 %.01, i64 0, metadata !24, metadata !14), !dbg !26
  %6 = zext i16 %.0 to i32, !dbg !31
  %7 = icmp slt i32 %6, 4, !dbg !34
  br i1 %7, label %8, label %17, !dbg !35

; <label>:8:                                      ; preds = %5
  %9 = zext i16 %.0 to i64, !dbg !37
  %10 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 %9, !dbg !37
  %11 = load i32, i32* %10, align 4, !dbg !37
  %12 = zext i16 %.01 to i32, !dbg !39
  %13 = add i32 %12, %11, !dbg !39
  %14 = trunc i32 %13 to i16, !dbg !39
  call void @llvm.dbg.value(metadata i16 %14, i64 0, metadata !24, metadata !14), !dbg !26
  br label %15, !dbg !40

; <label>:15:                                     ; preds = %8
  %16 = add i16 %.0, 1, !dbg !41
  call void @llvm.dbg.value(metadata i16 %16, i64 0, metadata !27, metadata !14), !dbg !29
  br label %5, !dbg !43, !llvm.loop !44

; <label>:17:                                     ; preds = %5
  %18 = zext i16 %.01 to i32, !dbg !47
  ret i32 %18, !dbg !48
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
!1 = !DIFile(filename: "c/07-loopsafe.c", directory: "/home/nick/teaching/886/overflower-template/test")
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
!24 = !DILocalVariable(name: "sum", scope: !6, file: !1, line: 5, type: !25)
!25 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!26 = !DILocation(line: 5, column: 18, scope: !6)
!27 = !DILocalVariable(name: "i", scope: !28, file: !1, line: 6, type: !25)
!28 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 3)
!29 = !DILocation(line: 6, column: 23, scope: !28)
!30 = !DILocation(line: 6, column: 8, scope: !28)
!31 = !DILocation(line: 6, column: 30, scope: !32)
!32 = !DILexicalBlockFile(scope: !33, file: !1, discriminator: 1)
!33 = distinct !DILexicalBlock(scope: !28, file: !1, line: 6, column: 3)
!34 = !DILocation(line: 6, column: 32, scope: !32)
!35 = !DILocation(line: 6, column: 3, scope: !36)
!36 = !DILexicalBlockFile(scope: !28, file: !1, discriminator: 1)
!37 = !DILocation(line: 7, column: 12, scope: !38)
!38 = distinct !DILexicalBlock(scope: !33, file: !1, line: 6, column: 42)
!39 = !DILocation(line: 7, column: 9, scope: !38)
!40 = !DILocation(line: 8, column: 3, scope: !38)
!41 = !DILocation(line: 6, column: 37, scope: !42)
!42 = !DILexicalBlockFile(scope: !33, file: !1, discriminator: 2)
!43 = !DILocation(line: 6, column: 3, scope: !42)
!44 = distinct !{!44, !45, !46}
!45 = !DILocation(line: 6, column: 3, scope: !28)
!46 = !DILocation(line: 8, column: 3, scope: !28)
!47 = !DILocation(line: 9, column: 10, scope: !6)
!48 = !DILocation(line: 9, column: 3, scope: !6)
