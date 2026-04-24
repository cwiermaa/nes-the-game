ProcessCollision:
	lda TargetStatus
	and #$02
	beq +
	rts

+
	lda BulletXH
	sta O1Left
	clc
	adc #8
	sta O1Right
	lda BulletYH
	sta O1Top
	clc
	adc #8
	sta O1Bottom

	lda TargetXH
	sta O2Left
	clc
	adc #4
	sta O2Right
	lda TargetYH
	sta O2Top
	clc
	adc TargetSize
	sta O2Bottom

	jsr Collide
	beq +
	clc
	lda ScoreL
	adc #1
	sta ScoreL
	lda ScoreH
	adc #0
	sta ScoreH
	lda TargetStatus
	ora #2
	sta TargetStatus
	lda #1
	sta $4015
	jsr Initiate
	lda #<TargetHit
	sta Sq1MusicLow
	sta Sq2MusicLow
	lda #>TargetHit
	sta Sq1MusicHigh
	sta Sq2MusicLow
+
	rts