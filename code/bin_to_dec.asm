
.DEFINE LowVar $30		;These are sample Variables
.DEFINE HighVar $31

.DEFINE TTThousands $32
.DEFINE TThousands $33
.DEFINE THundreds $34
.DEFINE TTens $35

.DEFINE First5 $36
.DEFINE Second4 $3B
.DEFINE Third3 $3F
.DEFINE Fourth2 $43

.DEFINE TThousandsPlace $45
.DEFINE ThousandsPlace $46
.DEFINE HundredsPlace $47
.DEFINE TensPlace $48
.DEFINE OnesPlace $49

.DEFINE CarryTheNumber $4A
.DEFINE Answer $4B
.DEFINE Answer2 $4C

BinToDec:
	lda LowVar
	and #$0F
	sta TTens
	lda LowVar
	lsr a
	lsr a
	lsr a
	lsr a
	sta THundreds

	lda HighVar
	and #$0F	
	sta TThousands
	lda HighVar
	lsr a
	lsr a
	lsr a
	lsr a
	sta TTThousands

	lda TTThousands
	sta Answer
	asl a
	asl a
	clc
	adc Answer
	sta TTThousands

	ldy TTThousands
	lda FHex.w,y
	sta First5	
	iny
	lda FHex.w,y
	sta First5+1
	iny
	lda FHex,y
	sta First5+2
	iny
	lda FHex.w,y
	sta First5+3
	iny
	lda FHex.w,y
	sta First5+4

	asl TThousands
	asl TThousands	;Multiply by 4. 4 digits for every $0X00


	ldy TThousands
	lda THex.w,y
	sta Second4
	iny
	lda THex.w,y
	sta Second4+1
	iny
	lda THex.w,y
	sta Second4+2
	iny
	lda THex.w,y
	sta Second4+3

	lda THundreds
	sta Answer
	asl THundreds	;Multiply by 3. 3 digits for every $00X0
	clc
	lda THundreds
	adc Answer
	sta THundreds

	ldy THundreds
	lda WHex.w,y
	sta Third3
	iny
	lda WHex.w,y
	sta Third3+1
	iny
	lda WHex.w,y
	sta Third3+2

	asl TTens		;Multiply by 2. 2 digits for every $000X

	ldy TTens
	lda OHex.w,y
	sta Fourth2
	iny
	lda OHex.w,y
	sta Fourth2+1
			;Now we have all values to add together.
			;240 cycles!

	clc
	lda First5+4
	adc Second4+3
	sta Answer
	clc
	lda Third3+2
	adc Fourth2+1
	sta Answer2
	clc
	lda Answer
	adc Answer2
	sta Answer
			;We have the ones digits all added up... In Hex.

	ldy Answer
	lda DecimalTable.w,y
	tax
	and #$F0	
	lsr a
	lsr a
	lsr a
	lsr a
	sta CarryTheNumber
	txa
	and #$0F
	sta OnesPlace
			;This method uses alot of RAM.

	clc
	lda First5+3
	adc Second4+2
	sta Answer
	clc
	lda Third3+1
	adc Fourth2
	sta Answer2
	clc
	lda Answer
	adc Answer2
	sta Answer
	clc
	lda Answer
	adc CarryTheNumber
	sta Answer

	ldy Answer
	lda DecimalTable.w,y
	tax
	and #$F0	
	lsr a
	lsr a
	lsr a
	lsr a
	sta CarryTheNumber
	txa
	and #$0F	
	sta TensPlace

	clc
	lda First5+2
	adc Second4+1
	sta Answer
	clc
	lda Third3
	adc Answer
	sta Answer
	clc
	lda Answer
	adc CarryTheNumber
	sta Answer

	ldy Answer
	lda DecimalTable.w,y
	tax
	and #$F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta CarryTheNumber
	txa
	and #$0F
	sta HundredsPlace

	clc
	lda First5+1
	adc Second4
	sta Answer
	clc
	lda Answer
	adc CarryTheNumber
	sta Answer

	ldy Answer
	lda DecimalTable.w,y
	tax
	and #$F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta CarryTheNumber
	txa
	and #$0F
	sta ThousandsPlace

	clc
	lda First5
	adc CarryTheNumber
	sta Answer

	ldy Answer
	lda DecimalTable.w,y
	tax
	and #$F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta CarryTheNumber
	txa
	and #$0F
	sta TThousandsPlace
	rts

DecimalTable:
	.db $00
	.db $01,$02,$03,$04,$05,$06,$07,$08,$09,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20
	.db $21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33,$34,$35,$36

FHex:
.db $00,$00,$00,$00,$00
.db $00,$04,$00,$09,$06
.db $00,$08,$01,$09,$02
.db $01,$02,$02,$08,$08
.db $01,$06,$03,$08,$04
.db $02,$00,$04,$08,$00
.db $02,$04,$05,$07,$06
.db $02,$08,$06,$07,$02
.db $03,$02,$07,$06,$08
.db $03,$06,$08,$06,$04
.db $04,$00,$09,$06,$00
.db $04,$05,$00,$05,$06
.db $04,$09,$01,$05,$02
.db $05,$03,$02,$04,$08
.db $05,$07,$03,$04,$04
.db $06,$01,$04,$04,$00

THex:
.db $00,$00,$00,$00
.db $00,$02,$05,$06
.db $00,$05,$01,$02
.db $00,$07,$06,$08
.db $01,$00,$02,$04
.db $01,$02,$08,$00
.db $01,$05,$03,$06
.db $01,$07,$09,$02
.db $02,$00,$04,$08
.db $02,$03,$00,$04
.db $02,$05,$06,$00
.db $02,$08,$01,$06
.db $03,$00,$07,$02
.db $03,$03,$02,$08
.db $03,$05,$08,$04
.db $03,$08,$04,$00

WHex:
.db $00,$00,$00
.db $00,$01,$06
.db $00,$03,$02
.db $00,$04,$08
.db $00,$06,$04
.db $00,$08,$00
.db $00,$09,$06
.db $01,$01,$02
.db $01,$02,$08
.db $01,$04,$04
.db $01,$06,$00
.db $01,$07,$06
.db $01,$09,$02
.db $02,$00,$08
.db $02,$02,$04
.db $02,$04,$00

OHex:
.db $0,$0
.db $0,$1
.db $0,$2
.db $0,$3
.db $0,$4
.db $0,$5
.db $0,$6
.db $0,$7
.db $0,$8
.db $0,$9
.db $1,$0
.db $1,$1
.db $1,$2
.db $1,$3
.db $1,$4
.db $1,$5