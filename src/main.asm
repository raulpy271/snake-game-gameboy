
INCLUDE "src/utils/hardware.inc"
INCLUDE "src/physics.asm"

SNAKE_MOVING_RIGHT EQU 1
SNAKE_MOVING_LEFT EQU 2
SNAKE_MOVING_UP EQU 3
SNAKE_MOVING_DOWN EQU 4

SECTION "VBlank Interrupt", ROM0[$40]
VBLankInterrupt:
    JP UpdateSnake

SECTION "Boot Vector", ROM0[$100]
    JR Main

SECTION "Main", ROM0[$150]
Main:
    CALL EnableTime
    CALL LCDOff
    CALL SetupScreen
    CALL SetupPalette
    CALL SetupLCD
    CALL EnableVBlank
    EI
    JP Sleep

SetupPalette:
    ld a, %11100100
    ld [rBGP], a
    ld [rOBP0], a
    RET

SetupScreen:
    LD DE, Tiles 
    LD HL, $8000
    LD BC, TilesEnd - Tiles
    CALL MEMCOPY
    LD DE, OAMData
    LD HL, $FE00
    LD BC, OAMDataEnd - OAMData
    CALL MEMCOPY
    RET

SetupLCD:
    ld a, LCDCF_ON + LCDCF_BGON + LCDCF_OBJON + LCDCF_BG8000
    ld [rLCDC], a
    RET

UpdateSnake:
    LD A, [MOVING]
    CP A, SNAKE_MOVING_LEFT
    CALL Z, MovingLeft
    LD A, [MOVING]
    CP A, SNAKE_MOVING_DOWN
    CALL Z, MovingDown
    LD A, [MOVING]
    CP A, SNAKE_MOVING_UP
    CALL Z, MovingUp
    LD A, [MOVING]
    CP A, SNAKE_MOVING_RIGHT
    CALL Z, MovingRight
    CALL SetCIfColision
    CALL C, SetRandomPositionFruit
    RETI

MoveFruit:
    LD A, [$FE05] ; Fruit X cordinate
    INC A
    LD [$FE05], A
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

SECTION "DATA", ROM0

MOVING: DB SNAKE_MOVING_RIGHT

Tiles:
    ; White tile
    DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    ; Snake tile
    INCBIN "tiles/snake.bin"
    ; Fruit tile
    INCBIN "tiles/fruit.bin"
TilesEnd:

OAMData:
    ; First Object - Sprite snake 
    ; Y = 16, X = 8, Tile number 1, No flags
    DB 16, 8, 1, 0 
    DB 50, 8, 2, 0 
OAMDataEnd:

