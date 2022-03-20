
SECTION "Utility Methods", ROM0

LCDOff:
	LD HL, rLCDC
    LD [HL], 0
	RET

Sleep:
    HALT
    JR Sleep

; DE - Origin
; HL - Destination
; BC - Size
MEMCOPY::
	LD A, [DE]
	LD [HL+], A
	INC DE
	DEC BC
	LD A, B
	CP 0
	JR NZ, MEMCOPY
	LD A, C
	CP 0
	JR NZ, MEMCOPY
	RET

EnableVBlank:
    LD HL, rSTAT
    SET 4, [HL]
    LD HL, rIE
    SET 0, [HL]
    LD HL, rIF
    RES 1, [HL]
    RET

EnableKeypad:
    LD HL, rIE
    SET 4, [HL]
    RET

EnableTime:
    LD A, %00000100
    LD [rTAC], A
    LD A, 0
    LD [rTMA], A
    RET

; B is larger than A? If yes set Carry Flag
BLargerThanA:
    SUB A, B
    RET

LD_A_RandomNumber:
    LD B, 7
    LD A, [rTIMA]
    BIT 0, A
    JP Z, TwoInstructions
    LD B, 11
TwoInstructions: 
    ADD A, B
    RR A
    RET

