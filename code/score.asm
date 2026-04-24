ProcessScore:
	lda ScoreL
	sta LowVar
	lda ScoreH
	sta HighVar
	jsr BinToDec
	lda TensPlace
	cmp OldTensPlace
	beq +
	lda TensPlace
	sta OldTensPlace
	lda Lives
	cmp #9
	beq +
	inc Lives
+
	rts