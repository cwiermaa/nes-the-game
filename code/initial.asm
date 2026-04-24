
	lda #<Return
	sta $14
	lda #>Return
	sta $15
	lda #$00
	sta $4015

	jsr cleartable
	lda #$10		;Y Poses for Score
	sta $304
	sta $308
	sta $30C
	sta $310
	sta $314
	lda #8		;X Poses for score
	sta $307
	clc
	adc #8
	sta $30B
	adc #8
	sta $30F
	adc #8
	sta $313
	adc #8
	sta $317

	lda #$80
	sta BulletYH	;Starting position for bullet
	lda #$70
	sta TargetYH	;Starting position for target
	lda #$10
	sta BulletXH
	lda #$D8
	sta TargetXH
	lda #$01		;Starting tiles for bullet and target
	sta BulletTile
	ldx #4
	ldy #0
	lda #$00
-
	sta TargetTile,y
	iny
	dex
	bne -

	lda TargetSize
	lsr a
	lsr a
	lsr a
	tax

	ldy #0		;Make Target Size
	lda #$02
-
	sta TargetTile,y
	iny
	dex
	bne -


	lda #1		;Set Target moving up
	sta TargetStatus

	lda #3
	sta Lives		;Set starting lives
	lda #8
	sta $32B
	sta $328

	lda #<HandleSound
	sta $14
	lda #>HandleSound
	sta $15

	lda #$00
	sta ScoreL
	sta ScoreH