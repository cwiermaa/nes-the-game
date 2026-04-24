;Multiplies an 8 bit value by a 16 bit value. At most takes about 440 cycles.
Multiply:
	lda #$00
	sta AnswerLow
	sta AnswerHigh
	sta Answer2High
	sta Multipliant2High

	ldx #8
-
	lsr Multiplier
	bcc +
	clc
	lda AnswerLow
	adc MultipliantLow
	sta AnswerLow
	lda AnswerHigh
	adc MultipliantHigh
	sta AnswerHigh
	lda Answer2High
	adc Multipliant2High
	sta Answer2High
+
	asl MultipliantLow
	rol MultipliantHigh
	rol Multipliant2High
	dex
	bne -
	rts