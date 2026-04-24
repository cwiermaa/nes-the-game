.include "memory.asm"
.incdir "code"
.include "byte_defs.asm"

.8bit
.bank 0 SLOT 0
.orga $C000
.section "nmi" FORCE	
nmi:
	jmp ($00)
	jmp ($02)
	jmp ($04)
	jmp ($06)
	jmp ($08)
	jmp ($0A)
	jmp ($0C)
	jmp ($0E)
	jmp ($10)
	jmp ($12)
	jmp ($14)
	jmp ($16)
	jmp ($18)
	jmp ($1A)
	jmp ($1C)
	jmp ($1E)
	lda #$00
	sta $20
	rti
Return:
	inc $20
	inc $20
	inc $20
	jmp ($20)
.ends
.section "reset" FREE
reset:
	.include "reset.asm"		;Includes basic initiations such as the pallete and clearing the name table
loop:
	jmp loop

irq:
	rti

Game:
	lda #3
	sta $4014
	jsr ProcessBullet
	jsr ProcessTarget
	jsr ProcessCollision
	jsr ProcessScore
	jsr DrawAll
	jsr ProcessCrossover
	jmp Return

DrawAll:
	jsr DrawScore
	jsr DrawBullet
	jsr DrawTarget
	jsr DrawLives
	rts

Initial:
	.include "initial.asm"
	lda #<Game
	sta $0
	lda #>Game
	sta $1
	jmp Return

TitleLoad:
	lda #3
	sta $4014
	jsr TitleControl
	jsr TitleDraw
	jmp Return

TitleScroll:
	dec Scroll
	lda #$00
	sta $2005
	lda Scroll
	sta $2005
	lda Scroll
	bne +
	lda #<TitleLoad
	sta $0
	lda #>TitleLoad
	sta $1
+
	jmp Return
Values:
	.dw TitleScroll, Return, Return, Return, Return, Return, Return, Return
	.dw Return, Return, HandleSound, Return, Return, Return, Return, Return

TitleDraw:
	jsr DrawTSize
	jsr DrawTSpeed
	jsr DrawBSpeed
	rts

cleartable:
	lda #$00
	sta $2001
	lda #$20
	sta $2006
	lda #$00
	sta $2006
	ldx #4
	ldy #0
-
	sta $2007
	iny
	bne -
	dex
	bne -

	lda #$00
	sta $2005
	sta $2005
	lda #$1E
	sta $2001
	rts


pal:
	.db $3F,$00,$10,$30,$3F,$00,$10,$30,$3F,$00,$10,$30,$3F,$00,$10,$30
	.db $3F,$00,$10,$30,$3F,$00,$10,$28,$3F,$00,$10,$30,$3F,$00,$10,$30

.incdir "code"
	.include "bullet.asm"
	.include "target.asm"
	.include "score.asm"
	.include "collide.asm"
	.include "bin_to_dec.asm"
	.include "draw.asm"
	.include "collisions.asm"
	.include "crossed.asm"
	.include "title_controls.asm"
	.include "initiate.asm"
.incdir "code/sound"
	.include "sound_include.asm"
.incdir ""
Title:
	;00111010 10110000 11100100 10101100
	;00010010 10100001 00001010 11101000
	;00010011 10110001 01101110 11101100
	;00010010 10100001 00101010 11101000
	;00010010 10110000 11101010 10101100

	.db $3A,$B0,$6E,$AC
	.db $12,$A0,$8A,$E8
	.db $13,$B0,$AE,$EC
	.db $12,$A0,$AA,$A8
	.db $12,$B0,$EA,$AC

QTargetSpeed:
	.db $06,$07,$08,$09,$0A,$06,$00,$0B,$0E,$0A,$0A,$0F
QTargetSize:
	.db $06,$07,$08,$09,$0A,$06,$00,$0B,$0C,$0D,$0A
QBulletSpeed:
	.db $10,$12,$11,$11,$0A,$06,$00,$0B,$0E,$0A,$0A,$0F
QHighScore:
	.db $13,$0C,$09,$13,$00,$0B,$14,$15,$08,$0A
QCopyRight:
	.db $3E,$00,$32,$30,$30,$38,$00,$14,$07,$11,$3B,$0C,$3D,$00,$3C,$0C,$0A,$08,$3A,$07,$07

CHR:
.incdir "data/graphics"
	.incbin "game1.chr"

LoadCHR:
	lda #<CHR
	sta TempAddL
	lda #>CHR
	sta TempAddH
	lda #$00
	sta $2006
	sta $2006
	ldy #0
-
	lda (TempAddL),y
	sta $2007
	iny
	bne -
	inc TempAddH
	ldx #$60
-
	lda (TempAddL),y
	sta $2007
	iny
	dex
	bne -
	clc
	lda TempAddL
	adc #$60
	sta TempAddL
	ldy #0

	lda #$03
	sta $2006
	lda #$00
	sta $2006
	ldx #$F0
-
	lda (TempAddL),y
	sta $2007
	iny
	dex
	bne -
	rts
.ends

.bank 0 SLOT 0
.orga $FFFA
.section "vectors" FORCE
.dw nmi
.dw reset
.dw irq
.ends