HandleEnvelopes:
	jsr CheckForTick
	jsr ReadMusicSq1
	jsr ReadSq2Music
	jsr Sq1ArpeggioEnvelope
	jsr Sq1VolumeEnvelope
	jsr Sq2Arpeggio
	jsr Sq2Envelope
	rts

Sq1ArpeggioEnvelope:
	.include "arpeggio.asm"

Sq1VolumeEnvelope:
	sec 
	lda Sq1VECounter
	sbc TempoTick
	sta Sq1VECounter
	beq +
	rts
+
	lda Sq1VESpeed
	sta Sq1VECounter

	lda Sq1VELow
	sta TempAddL
	lda Sq1VEHigh
	sta TempAddH

	ldy Sq1VELocation
	iny
	lda (TempAddL),y
	cmp #$FF
	beq ++
	cmp #$FE
	beq +
	sty Sq1VELocation.w
	jmp +++
+
	ldy #0
	lda (TempAddL),y
	sta Sq1VELocation.w
	tay
	lda (TempAddL),y
	jmp +++
++
	dey
	sty Sq1VELocation.w
	lda (TempAddL),y
+++
	sta ZTempVar1
	lda _$4000Copy
	and #$F0
	ora ZTempVar1
	sta _$4000Copy
	sta $4000
	rts

Sq2Envelope:
	.include "sq2_envelope.asm"