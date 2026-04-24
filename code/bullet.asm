ProcessBullet:
	clc
	lda BulletXL
	adc BulletSpeedL
	sta BulletXL
	lda BulletXH
	adc BulletSpeedH
	sta BulletXH
	lda BulletXHH
	adc #0
	sta BulletXHH

	ldx #1			;Controller read
	stx $4016.w
	dex
	stx $4016.w

	lda $4016
	lda $4016
	lda $4016
	lda $4016

	lda $4016
	and #1
	beq +
	jsr up
+
	lda $4016
	and #1
	beq +
	jsr dn
+
	lda $4016
	and #1
	beq +
	jsr lf
+
	lda $4016
	and #1
	beq +
	jsr rt
+
	rts

;******Button Routines**********

up:
	sec
	lda BulletYL
	sbc #0
	sta BulletYL
	lda BulletYH
	sbc #1
	sta BulletYH
	rts
dn:
	clc
	lda BulletYL
	adc #0
	sta BulletYL
	lda BulletYH
	adc #1
	sta BulletYH
	rts
lf:
	sec
	lda BulletXL
	sbc #$80
	sta BulletXL
	lda BulletXH
	sbc #$00
	sta BulletXH
	lda BulletXHH
	sbc #0
	sta BulletXHH
	rts
rt:
	clc
	lda BulletXL
	adc #0
	sta BulletXL
	lda BulletXH
	adc #1
	sta BulletXH
	lda BulletXHH
	adc #0
	sta BulletXHH
	rts