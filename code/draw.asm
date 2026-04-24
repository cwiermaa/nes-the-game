DrawBullet:
	lda BulletXH
	sta $303
	lda BulletYH
	sta $300
	lda BulletTile
	sta $301
	lda BulletAttribute
	sta $302
	rts

DrawScore:
	lda ScoreH
	sta HighVar
	lda ScoreL
	sta LowVar
	jsr BinToDec
	lda TThousandsPlace
	ora #$30
	sta $305
	lda ThousandsPlace
	ora #$30
	sta $309
	lda HundredsPlace
	ora #$30
	sta $30D
	lda TensPlace
	ora #$30
	sta $311
	lda OnesPlace
	ora #$30
	sta $315
	rts

DrawTarget:
	lda TargetXH
	sta $31B
	sta $31F
	sta $323
	sta $327
	clc
	lda TargetYH
	sta $318
	adc #8
	sta $31C
	adc #8
	sta $320
	adc #8
	sta $324
	lda TargetTile
	sta $319
	lda TargetTile2
	sta $31D
	lda TargetTile3
	sta $321
	lda TargetTile4
	sta $325
	lda TargetAttribute
	sta $31A
	sta $31E
	sta $322
	sta $326
	rts

DrawLives:
	lda Lives
	ora #$30
	sta $329
	rts


DrawTSize:
	lda #211
	sta $318
	lda #4
	sta $319
	clc
	lda TargetSize
	asl a
	asl a
	adc #58
	sta $31B
	rts

DrawTSpeed:
	lda #163
	sta $31C
	lda #4
	sta $31D
	lda TargetSpeedH
	sta ZTempVar1
	lda TargetSpeedL
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	lda ZTempVar1
	clc
	adc #58
	sta $31F
	rts
DrawBSpeed:
	lda #187
	sta $320
	lda #4
	sta $321
	lda BulletSpeedH
	sta ZTempVar1
	lda BulletSpeedL
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	asl a
	rol ZTempVar1
	lda ZTempVar1
	clc
	adc #58
	sta $323
	rts