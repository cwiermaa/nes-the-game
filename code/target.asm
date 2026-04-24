ProcessTarget:
	lda TargetStatus
	and #1
	beq MoveDown

	sec
	lda TargetYL
	sbc TargetSpeedL
	sta TargetYL
	lda TargetYH
	sbc TargetSpeedH
	sta TargetYH
	cmp #$10
	bcs +
	lda TargetStatus
	and #$FE
	sta TargetStatus
+
	rts

MoveDown:
	clc
	lda TargetYL
	adc TargetSpeedL
	sta TargetYL
	lda TargetYH
	adc TargetSpeedH
	sta TargetYH
	cmp #$D0
	bcc +
	lda TargetStatus
	ora #1
	sta TargetStatus
+
	rts