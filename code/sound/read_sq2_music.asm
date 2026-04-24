;ReadSq2Music:

	sec
	lda Sq2NoteLength
	sbc TempoTick
	sta Sq2NoteLength
	beq +
	rts
+
	dec Sq2NotesInARow
	bne +
	clc
	lda Sq2MusicLow
	adc Sq2NewAddLoc
	sta Sq2MusicLow
	lda Sq2MusicHigh
	adc #0
	sta Sq2MusicHigh
+
-
	ldy #0
	lda Sq2MusicLow
	sta TempAddL
	lda Sq2MusicHigh
	sta TempAddH
	lda (TempAddL),y
	sta MusicCommand1
	iny
	sty Sq2VELocation.w
	sty Sq2AELocation.w

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
	sta Sq2MusicLow
	iny
	lda (TempAddL),y
	sta Sq2MusicHigh
	jmp -
+
	lda MusicCommand1		;Changes Note
	and #$40
	beq +
	lda (TempAddL),y
	sta Sq2CurrentNote
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
	sta Sq2NoteLength
	sta Sq2NoteCounter
	iny
+

	lda MusicCommand1		;Defines Volume Envelope Location
	and #$08
	beq +
	lda (TempAddL),y
	sta Sq2VELow
	iny
	lda (TempAddL),y
	sta Sq2VEHigh
	iny
+
	lda MusicCommand1		;Defines Note Envelope Location
	and #$04
	beq +
	lda (TempAddL),y
	sta Sq2AELow
	iny
	lda (TempAddL),y
	sta Sq2AEHigh
	iny
+
	lda Sq2NotesInARow		;Defines if there's more than one note
	bne +++
	lda MusicCommand1
	and #$02
	beq +
	lda (TempAddL),y
	sta Sq2NotesInARow
	iny
	jmp ++
+
	lda #$01
	sta Sq2NotesInARow
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
	sta Sq2AESpeed
	iny
	lda (TempAdd2L),y
	sta Sq2VESpeed
	iny
	lda _$4004Copy
	and #$3F
	ora (TempAdd2L),y
	sta _$4004Copy
	iny
	lda (TempAdd2L),y
	sta Sq2VELow
	iny
	lda (TempAdd2L),y
	sta Sq2VEHigh
	iny
	lda (TempAdd2L),y
	sta Sq2AELow
	iny
	lda (TempAdd2L),y
	sta Sq2AEHigh
	ldy ZTempVar1
+
	lda MusicCommand2		;Defines Volume Envelope Speed
	and #$40
	beq +
	lda (TempAddL),y
	sta Sq2VESpeed
	iny
+
	lda MusicCommand2		;Defines Note Envelope Speed
	and #$20
	beq +
	lda (TempAddL),y
	sta Sq2AESpeed
	iny

+
	lda MusicCommand2
	and #$10
	beq +
	lda _$4004Copy			;Change Duty Cycle
	and #$3F
	ora (TempAddL),y
	sta _$4004Copy
	iny
+
	lda MusicCommand2
	and #$08
	beq +
	;lda _$4015Copy
	;eor #2
	;sta _$4015Copy
	lda #$00
	sta $4015
+
	lda Sq2NoteCounter
	sta Sq2NoteLength
	sty Sq2NewAddLoc.w
	rts