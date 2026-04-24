;Sq1Arpeggio:
	sec
	lda Sq1AECounter
	sbc TempoTick
	sta Sq1AECounter
	beq +
	rts

+
	lda Sq1AESpeed
	sta Sq1AECounter

	lda Sq1AELow
	sta TempAddL
	lda Sq1AEHigh
	sta TempAddH

	ldy Sq1AELocation.w
	lda (TempAddL),y
	cmp #$FF
	beq ++
	cmp #$FE
	beq +
-
	bpl ArpeggioNoteDown
	jmp ArpeggioNoteUp
++
	dey
	sty Sq1AELocation.w
	lda (TempAddL),y
	jmp -
+
	ldy #0
	lda (TempAddL),y
	tay
	lda (TempAddL),y
	jmp -

ArpeggioNoteDown:
	iny
	sty Sq1AELocation.w
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
	sta Sq1ArpegGraphic

	lda ZTempVar2
	eor #$03
	asl a
	sta ZTempVar1

	sec
	lda Sq1CurrentNote
	sbc ZTempVar1
	sta ZTempVar3
	sta Sq1PitchNote

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
	lda Sq1CurrentNote
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
	sta _$4002Copy
	lda ZTempVar2
	adc Answer2High
	sta ZTempVar1
	lda _$4003Copy
	and #$07
	cmp ZTempVar1
	beq +
	lda _$4003Copy
	and #$F8
	ora ZTempVar1
	sta _$4003Copy
	sta $4003
+
	lda _$4002Copy
	sta $4002
	jmp ArpeggioDone

ArpeggioNoteUp:
	
	iny
	sty Sq1AELocation.w
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
	sta Sq1ArpegGraphic

	lda ZTempVar2
	asl a
	sta ZTempVar1

	clc
	lda Sq1CurrentNote
	adc ZTempVar1
	sta ZTempVar3
	sta Sq1PitchNote
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
	sta _$4002Copy
	lda ZTempVar2
	sbc Answer2High
	sta ZTempVar1
	lda _$4003Copy
	and #$07
	cmp ZTempVar1
	beq +
	lda _$4003Copy
	and #$F8
	ora ZTempVar1
	sta _$4003Copy
	sta $4003
+
	lda _$4002Copy
	sta $4002
	jmp ArpeggioDone

ArpeggioDone:
	rts

Sq2Arpeggio:
	.include "sq2_arpeggio.asm"