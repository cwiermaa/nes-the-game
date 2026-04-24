ReadMusicSq1:
	sec
	lda Sq1NoteLength
	sbc TempoTick
	sta Sq1NoteLength
	beq +
	rts
+
	dec Sq1NotesInARow
	bne +
	clc
	lda Sq1MusicLow
	adc Sq1NewAddLoc
	sta Sq1MusicLow
	lda Sq1MusicHigh
	adc #0
	sta Sq1MusicHigh
+
	lda Sq1VESpeed
	sta Sq1VECounter
	lda Sq1AESpeed
	sta Sq1AECounter
-
	ldy #0
	lda Sq1MusicLow
	sta TempAddL
	lda Sq1MusicHigh
	sta TempAddH
	lda (TempAddL),y
	sta MusicCommand1

	iny
	sty Sq1VELocation.w
	sty Sq1AELocation.w

	and #$01
	beq +
	lda (TempAddL),y
	sta MusicCommand2
	iny
	jmp ++
+
	lda #$00
	sta MusicCommand2
++
	lda MusicCommand1
	and #$80
	beq +

	lda (TempAddL),y			;Goes to new location
	sta Sq1MusicLow
	iny
	lda (TempAddL),y
	sta Sq1MusicHigh
	jmp -
+
	lda MusicCommand1		;Changes Note
	and #$40
	beq +
	lda (TempAddL),y
	sta Sq1CurrentNote
	iny
+
	lda MusicCommand1		;Changes Length Low byte
	and #$20
	beq +
	lda (TempAddL),y
	sta MusicTempo
	iny
	lda #$00
	sta TempoTimer

+

	lda MusicCommand1		;Defines Length High Byte
	and #$10
	beq +
	lda (TempAddL),y
	sta Sq1NoteLength
	sta Sq1NoteCounter
	iny
+

	lda MusicCommand1		;Defines Volume Envelope Location
	and #$08
	beq +
	lda (TempAddL),y
	sta Sq1VELow
	iny
	lda (TempAddL),y
	sta Sq1VEHigh
	iny
+
	lda MusicCommand1		;Defines Note Envelope Location
	and #$04
	beq +
	lda (TempAddL),y
	sta Sq1AELow
	iny
	lda (TempAddL),y
	sta Sq1AEHigh
	iny
+
	lda Sq1NotesInARow		;Defines if there's more than one note
	bne +++
	lda MusicCommand1
	and #$02
	beq +
	lda (TempAddL),y
	sta Sq1NotesInARow
	iny
	jmp ++
+
	lda #$01
	sta Sq1NotesInARow
	jmp ++
+++
	iny
++

	lda MusicCommand2		;Changes Instrument
	and #$80
	beq +

	lda (TempAddL),y
	sta TempAdd2L
	iny
	lda (TempAddL),y
	sta TempAdd2H
	iny
	sty ZTempVar1
	ldy #0
	lda (TempAdd2L),y
	sta Sq1AESpeed
	iny
	lda (TempAdd2L),y
	sta Sq1VESpeed
	iny
	lda _$4000Copy
	and #$3F
	ora (TempAdd2L),y
	sta _$4000Copy
	iny
	lda (TempAdd2L),y
	sta Sq1VELow
	iny
	lda (TempAdd2L),y
	sta Sq1VEHigh
	iny
	lda (TempAdd2L),y
	sta Sq1AELow
	iny
	lda (TempAdd2L),y
	sta Sq1AEHigh
	ldy ZTempVar1
+
	lda MusicCommand2		;Defines Volume Envelope Speed
	and #$40
	beq +
	lda (TempAddL),y
	sta Sq1VESpeed
	iny
+
	lda MusicCommand2		;Defines Note Envelope Speed
	and #$20
	beq +
	lda (TempAddL),y
	sta Sq1AESpeed
	iny

+
	lda MusicCommand2
	and #$10
	beq +
	lda _$4000Copy			;Change Duty Cycle
	and #$3F
	ora (TempAddL),y
	sta _$4000Copy
	iny
+
	lda MusicCommand2
	and #$08
	beq +
	;lda _$4015Copy
	;eor #1
	;sta _$4015Copy
	lda #$00
	sta $4015
+
	lda Sq1NoteCounter
	sta Sq1NoteLength
	sty Sq1NewAddLoc.w
	rts

ReadSq2Music:
	.include "read_sq2_music.asm"

CheckForTick:
	ldx #0
	clc
	lda TempoTimer
	adc MusicTempo
	sta TempoTimer
	bcc +
	ldx #1
+
	stx TempoTick.w
	rts