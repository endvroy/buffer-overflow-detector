; ModuleID = '<stdin>'
source_filename = "c/09-almostunsafe.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 !dbg !8 {
  %3 = alloca [4 x i32], align 16
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !15, metadata !16), !dbg !17
  call void @llvm.dbg.value(metadata i8** %1, i64 0, metadata !18, metadata !16), !dbg !19
  call void @llvm.dbg.declare(metadata [4 x i32]* %3, metadata !20, metadata !16), !dbg !24
  %4 = bitcast [4 x i32]* %3 to i8*, !dbg !24
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 16, i32 16, i1 false), !dbg !24
  %5 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 4, !dbg !25
  %6 = ptrtoint i32* %5 to i32, !dbg !26
  ret i32 %6, !dbg !27
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
!llvm.module.flags = !{!5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 4.0.0 (tags/RELEASE_400/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "c/09-almostunsafe.c", directory: "/home/nick/teaching/886/overflower-template/test")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!8 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !9, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !12}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!15 = !DILocalVariable(name: "argc", arg: 1, scope: !8, file: !1, line: 3, type: !11)
!16 = !DIExpression()
!17 = !DILocation(line: 3, column: 10, scope: !8)
!18 = !DILocalVariable(name: "argv", arg: 2, scope: !8, file: !1, line: 3, type: !12)
!19 = !DILocation(line: 3, column: 23, scope: !8)
!20 = !DILocalVariable(name: "buffer", scope: !8, file: !1, line: 4, type: !21)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 128, elements: !22)
!22 = !{!23}
!23 = !DISubrange(count: 4)
!24 = !DILocation(line: 4, column: 12, scope: !8)
!25 = !DILocation(line: 5, column: 21, scope: !8)
!26 = !DILocation(line: 5, column: 10, scope: !8)
!27 = !DILocation(line: 5, column: 3, scope: !8)
