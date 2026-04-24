ProcessCrossover:
	lda BulletXHH
	bne +
	rts
+
	lda #$00
	sta BulletXHH
	lda TargetStatus
	and #2
	bne +
	dec Lives
	bpl +
	jsr GameOver
+
	lda TargetStatus
	and #$FD
	sta TargetStatus
	rts

GameOver:
	lda #<GOver
	sta $0
	lda #>GOver
	sta $1
	rts

GOver:
	ldx #0
	txa
-
	sta $200,x
	inx
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

	lda #<HandleSound
	sta $14
	lda #>HandleSound
	sta $15

	lda #$01
	sta $4015
	sta _$4015Copy
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

	lda #<GameOverM
	sta Sq1MusicLow
	sta Sq2MusicLow
	lda #>GameOverM
	sta Sq1MusicHigh
	sta Sq2MusicHigh

	lda #$00
	sta $2001
	lda #$21
	sta $2006
	lda #$CB
	sta $2006
	ldx #9
	ldy #0
-
	lda Game_Over.w,y
	sta $2007
	iny
	dex
	bne -

	lda #$00
	sta $2005
	sta $2005
	lda #$0E
	sta $2001

	lda #<GameOverWait
	sta $0
	lda #>GameOverWait
	sta $1
	jmp Return

GameOverWait:
	jsr GameOverControl
	jmp Return


Game_Over:
	.db $09,$07,$3A,$0A,$00,$15,$3B,$0A,$08

GameOverControl:
	ldx #1
	stx $4016.w
	dex
	stx $4016.w

	lda $4016
	lda $4016
	lda $4016
	lda $4016
	and #1
	beq +
	jsr GetHighScore
	jmp Reset2
+
	lda $4016
	lda $4016
	lda $4016
	lda $4016
	rts

GetHighScore:
	lda ScoreH
	cmp HScoreH
	bcc +
	lda ScoreL
	cmp HScoreL
	bcc +
	lda ScoreH
	sta HScoreH
	lda ScoreL
	sta HScoreL
+
	rts