Instrument1:
	.db $01,$01,$80
	.dw VolumeEnvelope1, ArpeggioEnvelope1

Instrument2:
	.db $01,$01,$80
	.dw VolumeEnvelope2, ArpeggioEnvelope1

Instrument3:
	.db $01,$01,$80
	.dw VolumeEnvelope3, ArpeggioEnvelope1

VolumeEnvelope3:
	.db $08,$08,$07,$07,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01,$00,$FF
VolumeEnvelope2:
	.db $01,$05,$FF
ArpeggioEnvelope2:
	.db $01,$80,$FE
VolumeEnvelope1:
	.db $05,$00,$01,$02,$06,$08,$09,$08,$07,$FE
	.db $00,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00,$FF
	.db $08,$06,$04,$02,$00,$FC
ArpeggioEnvelope1:
	.db $01,$80,$88,$80,$7D,$FE



ArpeggioAllDown:
	.db $80,$FE
.db $7D, $7C, $7B, $7A, $79, $78, $77, $76, $75, $74, $73, $72, $71, $70
.db $6F, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60
.db $5F, $5E, $5D, $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50
.db $4F, $4E, $4D, $4C, $4B, $4A, $49, $48, $47, $46, $45, $44, $43, $42, $41, $40
.db $3F, $3E, $3D, $3C, $3B, $3A, $39, $38, $37, $36, $35, $34, $33, $32, $31, $30
.db $2F, $2E, $2D, $2C, $2B, $2A, $29, $28, $27, $26, $25, $24, $23, $22, $21, $20
.db $1F, $1E, $1D, $1C, $1B, $1A, $19, $18, $17, $16, $15, $14, $13, $12, $11, $10
.db $F, $E, $D, $C, $B, $A, $9, $8, $7, $6, $5, $4, $3, $2, $1, $0,$FF

