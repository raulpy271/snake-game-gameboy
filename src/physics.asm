
INCLUDE "src/utils/hardware.inc"
INCLUDE "src/utils/subprograms.asm"
SECTION "Mathods related to game physics", ROM0

; Set the carry Flag if thare's a colision
SetCIfColision:
    CALL SetCIfVerticalColision
    CALL C, SetCIfHorizontalColision
    RET

SetCIfHorizontalColision:
    ; H = Snake X position
    ; L = Fruit X position
    LD A, [$FE01] 
    LD H, A
    LD A, [$FE05] 
    LD L, A

    ; C = Snake X + 8 position
    LD A, H
    ADD A, 8 
    LD C, A

    ; D = Fruit X + 8 position
    LD A, L 
    ADD A, 8 
    LD D, A

    ; Set Carry if C larger than L
    LD B, C
    LD A, L
    CALL BLargerThanA
    RET NC

    CCF ; Reset Carry

    ; Set Carry if D larger than H
    LD B, D
    LD A, H
    CALL BLargerThanA
    RET

SetCIfVerticalColision:
    ; H = Snake Y position
    ; L = Fruit Y position
    LD A, [$FE00] 
    LD H, A
    LD A, [$FE04] 
    LD L, A

    ; C = Snake Y + 8 position
    LD A, H
    ADD A, 8 
    LD C, A

    ; D = Fruit Y + 8 position
    LD A, L 
    ADD A, 8 
    LD D, A

    ; Set Carry if C larger than L
    LD B, C
    LD A, L
    CALL BLargerThanA
    RET NC

    CCF ; Reset Carry

    ; Set Carry if D larger than H
    LD B, D
    LD A, H
    CALL BLargerThanA
    RET

SetRandomPositionFruit:
    CALL LD_A_RandomCordinate
    LD [$FE04], A
    CALL LD_A_RandomCordinate
    LD [$FE05], A
    RET

; Set A register in range: 16 ... 144 + 8
LD_A_RandomCordinate:
    LD A, 0
    CALL LD_A_RandomNumber
    LD B, (144 + 16) - 8
    LD C, A
    CALL BLargerThanA
    LD A, C
    JP NC, LD_A_RandomCordinate
    LD B, 16
    LD C, A
    CALL BLargerThanA
    LD A, C
    JP C, LD_A_RandomCordinate
    RET

MovingLeft:
    LD HL, $FE01
    LD A, [HL]
    DEC A
    LD [HL], A
    RET

MovingDown:
   LD HL, $FE00
   LD A, [HL]
   INC A
   LD [HL], A
   RET

MovingRight:
   LD HL, $FE01
   LD A, [HL]
   INC A
   LD [HL], A
   RET

MovingUp:
   LD HL, $FE00
   LD A, [HL]
   DEC A
   LD [HL], A
   RET

