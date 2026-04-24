
	cld
	sei
	ldx #$FF
	txs

	lda #$00
	sta $2000
	sta $2001

	ldx #0
	txa
-
	sta $0,x
	sta $100,x
	sta $200,x
	sta $400,x
	sta $500,x
	sta $600,x
	sta $700,x
	inx
	bne -

-
	bit $2002
	bpl -
-
	bit $2002
	bpl -

	lda #8
	sta TargetSize
	lda #$00		;Set default bullet speed
	sta BulletSpeedL
	lda #$01
	sta BulletSpeedH
	lda #32
	sta TargetSize

Reset2:
	ldx #0
	txa
-
	sta $300,x
	sta $200,x
	inx
	bne -

	lda #3
	sta $4014

	jsr cleartable

	lda #$00
	sta $2001
	sta TitleMode

	lda #$20
	sta $2006
	lda #$22
	sta $2006
	ldx #10
	ldy #0
-
	lda QHighScore.w,y
	sta $2007
	iny
	dex
	bne -

	lda HScoreH
	sta HighVar
	lda HScoreL
	sta LowVar
	jsr BinToDec

	lda #$20
	sta $2006
	lda #$38
	sta $2006
	ldx #5
	ldy #0
-
	lda $45,y
	ora #$30
	sta $2007
	iny
	dex
	bne -

	ldx #20
	ldy #0
	lda #$20
	sta $2006
	lda #$60
	sta $2006
;******************************************
-
	lda Title.w,y
	sta ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	asl ZTempVar1
	lda ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	asl ZTempVar1
	lda ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	asl ZTempVar1
	lda ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	asl ZTempVar1
	lda ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	asl ZTempVar1
	lda ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	asl ZTempVar1
	lda ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	asl ZTempVar1
	lda ZTempVar1
	and #$80
	beq +
	lda #$03
	jmp ++
+
	lda #$00
++
	sta $2007
	iny
	dex
	beq +
	jmp -
+

;******************************************

	lda #$22
	sta $2006
	lda #$69
	sta $2006
	ldx #12
	ldy #0
-
	lda QTargetSpeed.w,y
	sta $2007
	iny
	dex
	bne -


	lda #$22
	sta $2006
	lda #$C9
	sta $2006
	ldx #12
	ldy #0
-
	lda QBulletSpeed.w,y
	sta $2007
	iny
	dex
	bne -

	lda #$23
	sta $2006
	lda #$29
	sta $2006
	ldx #11
	ldy #0
-
	lda QTargetSize.w,y
	sta $2007
	iny
	dex
	bne -

	lda #$23
	sta $2006
	lda #$85
	sta $2006
	ldx #21
	ldy #0
-
	lda QCopyRight.w,y
	sta $2007
	iny
	dex
	bne -

;***********************
	lda #58
	sta $303
	sta $307
	sta $30B
	lda #163
	sta $300
	sta $30C
	lda #187
	sta $304
	sta $310
	lda #211
	sta $308
	sta $314
	lda #5
	sta $301
	sta $305
	sta $309
	sta $30D
	sta $311
	sta $315
	lda #186
	sta $30F
	sta $313
	sta $317
	lda #1
	sta $31E

	sta TargetStatus

	lda #$F0
	sta Scroll
	lda #1
	sta TargetSpeedH

;***********************
	
	lda #$3F
	sta $2006
	lda #$00
	sta $2006
	ldx #32
	ldy #0

palload:
	lda pal.w,y
	sta $2007
	iny
	dex
	bne palload
	jsr LoadCHR
	lda #$00
	sta $2005
	lda #$F0
	sta $2005

	ldx #0
	ldy #16
-
	lda Values.w,x
	sta $0,x
	inx
	lda Values.w,x
	sta $0,x
	inx
	dey
	bne -

	lda #$1E
	sta $2001
	lda #$80
	sta $2000
	lda #$C0
	sta $21

	.include "sound_init.asm"