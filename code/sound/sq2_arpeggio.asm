;Sq2Arpeggio:

	sec
	lda Sq2AECounter
	sbc TempoTick
	sta Sq2AECounter
	beq +
	rts

+
	lda Sq2AESpeed
	sta Sq2AECounter

	lda Sq2AELow
	sta TempAddL
	lda Sq2AEHigh
	sta TempAddH

	ldy Sq2AELocation
	lda (TempAddL),y
	cmp #$FF
	beq ++
	cmp #$FE
	beq +
-
	bpl ArpeggioNoteDown2
	jmp ArpeggioNoteUp2
++
	dey
	sty Sq2AELocation.w
	lda (TempAddL),y
	jmp -
+
	ldy #0
	lda (TempAddL),y
	tay
	lda (TempAddL),y
	jmp -

ArpeggioNoteDown2:
	iny
	sty Sq2AELocation.w
	sta ZTempVar1
	lda #$00
	sta ZTempVar2

	lda ZTempVar1
	asl a
	asl a
	rol ZTempVar2
	asl a
	rol ZTempVar2

	lda ZTempVar1
	and #$1F
	sta ZTempVar1
	eor #$1F
	;sec
	;lda #$20
	;sbc ZTempVar1
	sta Multiplier
	ora #$80
	sta Sq2ArpegGraphic

	lda ZTempVar2
	eor #$03
	asl a
	sta ZTempVar1

	sec
	lda Sq2CurrentNote
	sbc ZTempVar1
	sta ZTempVar3
	sta Sq2PitchNote

	lda ZTempVar2
	eor #$03
	tax
	inx
	txa
	asl a
	sta ZTempVar1
					;6 - 11, 4 - 10, 2 - 01, 0 - 00
					;EOR 6 - 00, 4 - 01, 2 - 10, 0 - 11
					;We want 6 - 01, 4 - 10, 2 - 11, 0 - 100
	sec
	lda Sq2CurrentNote
	sbc ZTempVar1
	tax

	lda NoteArpeggioTable.w,x
	sta MultipliantLow
	inx
	lda NoteArpeggioTable.w,x
	sta MultipliantHigh
	jsr Multiply


	ldx ZTempVar3
	lda NotesTable.w,x
	sta ZTempVar2
	inx
	lda NotesTable.w,x
	sta ZTempVar1

	clc
	lda ZTempVar1
	adc AnswerHigh
	sta _$4006Copy
	lda ZTempVar2
	adc Answer2High
	sta ZTempVar1
	lda _$4007Copy
	and #$07
	cmp ZTempVar1
	beq +
	lda _$4007Copy
	and #$F8
	ora ZTempVar1
	sta _$4007Copy
	sta $4007
+
	lda _$4006Copy
	sta $4006
	jmp ArpeggioDone2

ArpeggioNoteUp2:
	
	iny
	sty Sq2AELocation.w
	sta ZTempVar1
	lda #$00
	sta ZTempVar2

	lda ZTempVar1
	asl a
	asl a
	rol ZTempVar2
	asl a
	rol ZTempVar2

	lda ZTempVar1
	and #$1F
	sta Multiplier
	sta Sq2ArpegGraphic

	lda ZTempVar2
	asl a
	sta ZTempVar1

	clc
	lda Sq2CurrentNote
	adc ZTempVar1
	sta ZTempVar3
	sta Sq2PitchNote
	tax

					;6 - 11, 4 - 10, 2 - 01, 0 - 00
					;EOR 6 - 00, 4 - 01, 2 - 10, 0 - 11
					;We want 6 - 01, 4 - 10, 2 - 11, 0 - 100

	lda NoteArpeggioTable.w,x
	sta MultipliantLow
	inx
	lda NoteArpeggioTable.w,x
	sta MultipliantHigh
	jsr Multiply


	ldx ZTempVar3
	lda NotesTable.w,x
	sta ZTempVar2
	inx
	lda NotesTable.w,x
	sta ZTempVar1

	sec
	lda ZTempVar1
	sbc AnswerHigh
	sta _$4006Copy
	lda ZTempVar2
	sbc Answer2High
	sta ZTempVar1
	lda _$4007Copy
	and #$07
	cmp ZTempVar1
	beq +
	lda _$4006Copy
	and #$F8
	ora ZTempVar1
	sta _$4007Copy
	sta $4007
+
	lda _$4006Copy
	sta $4006
	jmp ArpeggioDone2

ArpeggioDone2:
	rts