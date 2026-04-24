TitleControl:
	ldx #1
	stx $4016.w
	dex
	stx $4016.w

	lda ControlNew
	sta ControlOld

	ldx #8
-
	lda $4016
	lsr a
	rol ControlNew
	dex
	bne -

	lda ControlNew
	and #$10
	beq +
	jmp TitleStart
+
	lda #$00
	sta TargetStatus

	lda ControlNew
	and #8
	beq +
	jsr TitleUp
+
	lda ControlNew
	and #4
	beq +
	jsr TitleDn
+
	lda ControlNew
	and #2
	beq +
	jsr TGetModeAddsL
+
	lda ControlNew
	and #1
	beq +
	jsr TGetModeAddsR
+
	rts

TitleStart:
	lda TargetStatus
	bne +
	lda #<Initial
	sta $0
	lda #>Initial
	sta $1
+
	rts

TitleLeft1:
	lda TargetSpeedH
	bne ++
	lda TargetSpeedL
	beq +
++
	sec
	lda TargetSpeedL
	sbc #$20
	sta TargetSpeedL
	lda TargetSpeedH
	sbc #$00
	sta TargetSpeedH
+
	lda #<Return
	sta $2
	lda #>Return	
	sta $3
	jmp Return
TitleRight1:
	lda TargetSpeedH
	cmp #4
	beq +
	clc
	lda TargetSpeedL
	adc #$20
	sta TargetSpeedL
	lda TargetSpeedH
	adc #$00
	sta TargetSpeedH
+
	lda #<Return
	sta $4
	lda #>Return
	sta $5
	jmp Return

TitleUp:
	lda ControlNew
	and ControlOld
	and #8
	bne +
	lda TitleMode
	beq +
	dec TitleMode
	jsr TGetColors
+
	rts

TitleDn:
	lda ControlNew
	and ControlOld
	and #4
	bne +
	lda TitleMode
	cmp #2
	beq +
	inc TitleMode
	jsr TGetColors
+
	rts

TGetModeAddsL:
	lda TitleMode
	bne +
	lda #<TitleLeft1
	sta $2
	lda #>TitleLeft1
	sta $3
	rts
+
	lda TitleMode
	cmp #1
	bne +
	lda #<TitleLeft2
	sta $2
	lda #>TitleLeft2
	sta $3
	rts
+
	lda #<TitleLeft3
	sta $2
	lda #>TitleLeft3
	sta $3
	rts


TGetModeAddsR:
	lda TitleMode
	bne +
	lda #<TitleRight1
	sta $4
	lda #>TitleRight1
	sta $5
	rts
+
	lda TitleMode
	cmp #1
	bne +
	lda #<TitleRight2
	sta $4
	lda #>TitleRight2
	sta $5
	rts
+
	lda #<TitleRight3
	sta $4
	lda #>TitleRight3
	sta $5
	rts

TGetColors:
	lda TitleMode
	bne +
	lda #1
	sta $31E
	lda #0
	sta $31A
	sta $322
	rts
+
	lda TitleMode
	cmp #1
	bne +
	lda #1
	sta $322
	lda #0
	sta $31A
	sta $31E
	rts
+
	lda #1
	sta $31A
	lda #0
	sta $31E
	sta $322
	rts

TitleLeft2:
	lda BulletSpeedH
	bne ++
	lda BulletSpeedL
	beq +
++
	sec
	lda BulletSpeedL
	sbc #$20
	sta BulletSpeedL
	lda BulletSpeedH
	sbc #$00
	sta BulletSpeedH
+
	lda #<Return
	sta $2
	lda #>Return	
	sta $3
	jmp Return
TitleRight2:
	lda BulletSpeedH
	cmp #4
	beq +
	clc
	lda BulletSpeedL
	adc #$20
	sta BulletSpeedL
	lda BulletSpeedH
	adc #$00
	sta BulletSpeedH
+
	lda #<Return
	sta $4
	lda #>Return
	sta $5
	jmp Return
TitleLeft3:
	lda ControlNew
	and ControlOld
	and #2
	bne +
	lda TargetSize
	cmp #8
	beq +
	sec
	lda TargetSize
	sbc #8
	sta TargetSize
+
	lda #<Return
	sta $2
	lda #>Return
	sta $3
	jmp Return
TitleRight3:
	lda ControlNew
	and ControlOld
	and #1
	bne +
	lda TargetSize
	cmp #32
	beq +
	clc
	lda TargetSize
	adc #8
	sta TargetSize
+
	lda #<Return
	sta $4
	lda #>Return
	sta $5
	jmp Return
