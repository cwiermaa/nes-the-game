Initiate:
	ldx #$40
	lda #$00
	tay
-
	sta $2C0,y
	iny
	dex
	bne -

	lda Instrument1.w
	sta Sq1AESpeed
	sta Sq2AESpeed
	lda Instrument1.w+1
	sta Sq1VESpeed
	sta Sq2VESpeed
	lda Instrument1.w+3
	sta Sq1VELow
	sta Sq2VELow
	lda Instrument1.w+4
	sta Sq1VEHigh
	sta Sq2VEHigh
	lda Instrument1.w+5
	sta Sq1AELow
	sta Sq2AELow
	lda Instrument1.w+6
	sta Sq1AEHigh
	sta Sq2AEHigh

	lda #$01
	sta Sq1NotesInARow
	sta Sq1NoteLength
	sta Sq1AECounter
	sta Sq1VECounter

	sta Sq2NotesInARow
	sta Sq2NoteLength
	sta Sq2AECounter
	sta Sq2VECounter

	lda #$80
	sta MusicTempo

	lda #$B8
	sta $4000
	sta _$4000Copy
	sta _$4004Copy
	lda #$08
	sta $4001
	ldx #40
	stx Sq1CurrentNote.w
	stx Sq2CurrentNote.w
	lda NotesTable.w,x
	sta _$4003Copy
	sta _$4007Copy
	sta $4003
	inx
	lda NotesTable.w,x
	sta _$4002Copy
	sta _$4006Copy
	sta $4002
	rts