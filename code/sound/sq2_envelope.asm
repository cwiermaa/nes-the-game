;Sq2Envelope:

	sec 
	lda Sq2VECounter
	sbc TempoTick
	sta Sq2VECounter
	beq +
	rts
+
	lda Sq2VESpeed
	sta Sq2VECounter

	lda Sq2VELow
	sta TempAddL
	lda Sq2VEHigh
	sta TempAddH

	ldy Sq2VELocation
	iny
	lda (TempAddL),y
	cmp #$FF
	beq ++
	cmp #$FE
	beq +
	sty Sq2VELocation.w
	jmp +++
+
	ldy #0
	lda (TempAddL),y
	tay
	sty Sq2VELocation.w
	lda (TempAddL),y
	jmp +++
++
	dey
	sty Sq2VELocation.w
	lda (TempAddL),y
+++
	sta ZTempVar1
	lda _$4004Copy
	and #$F0
	ora ZTempVar1
	sta _$4004Copy
	sta $4004
	rts