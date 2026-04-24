Music:
	;7 - Go to $xxxx, 6 - Change Note, 5 - Tempo Ticks, 4 - Number Of Ticks, 3 - Change VE, 2 - Change AE, 1 - Play note
	;More than once, 0 - More options
	;7 - Change instrument, 6 - Change VE Speed, 5 - Change AE Speed, 4 - Change Duty Cycle


	.db %01010001,%10010000,Bb+O3,$08,<Instrument1,>Instrument1,$00
	.db %01010000,C+O3,$08
	.db $40,D+O3
	.db $40,Eb+O3
	.db $40,F+O3
	.db $40,G+O3
	.db $40,A+O4
	.db $50,Bb+O4,$10
	.db $50,A+O4,$08
	.db $40,G+O3
	.db $40,F+O3
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,C+O3
	.db $50,Bb+O3,$20
	.db $01,$08
-
	.db $80
	.dw -


Music2:

	.db %01010001,%10010000,D+O3,$08,<Instrument1,>Instrument1,$00
	.db $40,Eb+O3
	.db $40,F+O3
	.db $40,G+O3
	.db $40,A+O4
	.db $40,Bb+O4
	.db $40,C+O4
	.db $50,D+O4,$10
	.db $50,C+O4,$08
	.db $40,Bb+O4
	.db $40,A+O4
	.db $40,G+O3
	.db $40,F+O3
	.db $40,Eb+O3
	.db $50,D+O3,$20
	.db $01,$08
-
	.db $80
	.dw -

GameOverM:
	.db %01010001,%10010000,D+O3,$02,<Instrument2,>Instrument2,$00
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,Eb+O3
	.db $40,D+O3
	.db $40,Eb+O3
	.db $50,D+O3,$10
	.db $01,$08
-
	.db $80
	.dw -

TargetHit:
	.db %01010001,%10010000,F+O3,$20,<Instrument3,>Instrument3,$00
	.db $01,$08
-
	.db $80
	.dw -

HandleSound:
	jsr HandleEnvelopes
	jmp Return