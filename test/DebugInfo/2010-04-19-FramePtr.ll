; RUN: %llc_dwarf -asm-verbose -O1 -o %t < %s
; RUN: grep DW_AT_APPLE_omit_frame_ptr %t
; RUN: %llc_dwarf -disable-fp-elim -asm-verbose -O1 -o %t < %s
; RUN: grep -v DW_AT_APPLE_omit_frame_ptr %t


define i32 @foo() nounwind ssp {
entry:
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 42, i32* %0, align 4, !dbg !0
  %1 = load i32, i32* %0, align 4, !dbg !0             ; <i32> [#uses=1]
  store i32 %1, i32* %retval, align 4, !dbg !0
  br label %return, !dbg !0

return:                                           ; preds = %entry
  %retval1 = load i32, i32* %retval, !dbg !0           ; <i32> [#uses=1]
  ret i32 %retval1, !dbg !7
}

!llvm.dbg.cu = !{!3}
!llvm.module.flags = !{!12}
!9 = !{!1}

!0 = !DILocation(line: 2, scope: !1)
!1 = !DISubprogram(name: "foo", linkageName: "foo", line: 2, isLocal: false, isDefinition: true, virtualIndex: 6, isOptimized: false, scopeLine: 2, file: !10, scope: null, type: !4, function: i32 ()* @foo)
!2 = !DIFile(filename: "a.c", directory: "/tmp")
!3 = distinct !DICompileUnit(language: DW_LANG_C89, producer: "4.2.1 (Based on Apple Inc. build 5658) (LLVM build)", isOptimized: false, emissionKind: 0, file: !10, enums: !11, retainedTypes: !11, subprograms: !9, imports:  null)
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(tag: DW_TAG_base_type, name: "int", size: 32, align: 32, encoding: DW_ATE_signed)
!7 = !DILocation(line: 2, scope: !8)
!8 = distinct !DILexicalBlock(line: 2, column: 0, file: !10, scope: !1)
!10 = !DIFile(filename: "a.c", directory: "/tmp")
!11 = !{}
!12 = !{i32 1, !"Debug Info Version", i32 3}
