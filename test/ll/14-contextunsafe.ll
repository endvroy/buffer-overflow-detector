; ModuleID = '<stdin>'
source_filename = "c/14-contextunsafe.c"
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
define i32 @nested(i32, i32) #0 !dbg !13 {
  %3 = alloca [4 x i32], align 16
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !16, metadata !17), !dbg !18
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !19, metadata !17), !dbg !20
  call void @llvm.dbg.declare(metadata [4 x i32]* %3, metadata !21, metadata !17), !dbg !26
  %4 = bitcast [4 x i32]* %3 to i8*, !dbg !26
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 16, i32 16, i1 false), !dbg !26
  %5 = add nsw i32 %0, %1, !dbg !27
  %6 = sext i32 %5 to i64, !dbg !28
  %7 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 %6, !dbg !28
  %8 = load i32, i32* %7, align 4, !dbg !28
  ret i32 %8, !dbg !29
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

; Function Attrs: noinline nounwind uwtable
define i32 @extrawrapper(i32, i32) #0 !dbg !30 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !31, metadata !17), !dbg !32
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !33, metadata !17), !dbg !34
  %3 = call i32 @nested(i32 %0, i32 %1), !dbg !35
  ret i32 %3, !dbg !36
}

; Function Attrs: noinline nounwind uwtable
define i32 @wrapper(i32, i32) #0 !dbg !37 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !38, metadata !17), !dbg !39
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !40, metadata !17), !dbg !41
  %3 = call i32 @extrawrapper(i32 %0, i32 %1), !dbg !42
  ret i32 %3, !dbg !43
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 !dbg !44 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !50, metadata !17), !dbg !51
  call void @llvm.dbg.value(metadata i8** %1, i64 0, metadata !52, metadata !17), !dbg !53
  call void @llvm.dbg.declare(metadata !2, metadata !54, metadata !17), !dbg !55
  %3 = call i32 @wrapper(i32 1, i32 2), !dbg !56
  %4 = call i32 @wrapper(i32 0, i32 3), !dbg !57
  %5 = add nsw i32 %3, %4, !dbg !59
  ret i32 %5, !dbg !60
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
!1 = !DIFile(filename: "c/14-contextunsafe.c", directory: "/home/nick/teaching/886/overflower-template/test")
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
!15 = !{!9, !9, !9}
!16 = !DILocalVariable(name: "lower", arg: 1, scope: !13, file: !1, line: 13, type: !9)
!17 = !DIExpression()
!18 = !DILocation(line: 13, column: 12, scope: !13)
!19 = !DILocalVariable(name: "upper", arg: 2, scope: !13, file: !1, line: 13, type: !9)
!20 = !DILocation(line: 13, column: 23, scope: !13)
!21 = !DILocalVariable(name: "buffer", scope: !13, file: !1, line: 14, type: !22)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 128, elements: !24)
!23 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!24 = !{!25}
!25 = !DISubrange(count: 4)
!26 = !DILocation(line: 14, column: 12, scope: !13)
!27 = !DILocation(line: 15, column: 23, scope: !13)
!28 = !DILocation(line: 15, column: 10, scope: !13)
!29 = !DILocation(line: 15, column: 3, scope: !13)
!30 = distinct !DISubprogram(name: "extrawrapper", scope: !1, file: !1, line: 19, type: !14, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!31 = !DILocalVariable(name: "lower", arg: 1, scope: !30, file: !1, line: 19, type: !9)
!32 = !DILocation(line: 19, column: 18, scope: !30)
!33 = !DILocalVariable(name: "upper", arg: 2, scope: !30, file: !1, line: 19, type: !9)
!34 = !DILocation(line: 19, column: 29, scope: !30)
!35 = !DILocation(line: 20, column: 10, scope: !30)
!36 = !DILocation(line: 20, column: 3, scope: !30)
!37 = distinct !DISubprogram(name: "wrapper", scope: !1, file: !1, line: 24, type: !14, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!38 = !DILocalVariable(name: "lower", arg: 1, scope: !37, file: !1, line: 24, type: !9)
!39 = !DILocation(line: 24, column: 13, scope: !37)
!40 = !DILocalVariable(name: "upper", arg: 2, scope: !37, file: !1, line: 24, type: !9)
!41 = !DILocation(line: 24, column: 24, scope: !37)
!42 = !DILocation(line: 25, column: 10, scope: !37)
!43 = !DILocation(line: 25, column: 3, scope: !37)
!44 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 29, type: !45, isLocal: false, isDefinition: true, scopeLine: 29, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!9, !9, !47}
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!50 = !DILocalVariable(name: "argc", arg: 1, scope: !44, file: !1, line: 29, type: !9)
!51 = !DILocation(line: 29, column: 10, scope: !44)
!52 = !DILocalVariable(name: "argv", arg: 2, scope: !44, file: !1, line: 29, type: !47)
!53 = !DILocation(line: 29, column: 23, scope: !44)
!54 = !DILocalVariable(name: "index", scope: !44, file: !1, line: 30, type: !9)
!55 = !DILocation(line: 30, column: 7, scope: !44)
!56 = !DILocation(line: 31, column: 10, scope: !44)
!57 = !DILocation(line: 31, column: 25, scope: !58)
!58 = !DILexicalBlockFile(scope: !44, file: !1, discriminator: 1)
!59 = !DILocation(line: 31, column: 23, scope: !44)
!60 = !DILocation(line: 31, column: 3, scope: !44)
