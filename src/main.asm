
INCLUDE "src/utils/hardware.inc"
INCLUDE "src/physics.asm"

SNAKE_MOVING_RIGHT EQU 1
SNAKE_MOVING_LEFT EQU 2
SNAKE_MOVING_UP EQU 3
SNAKE_MOVING_DOWN EQU 4

SNAKE_MOVING_DEFAULT EQU SNAKE_MOVING_DOWN

SECTION "VBlank Interrupt", ROM0[$40]
VBLankInterrupt:
    JP UpdateSnake

SECTION "Keypad Interrupt", ROM0[$60]
KeypadInterrupt:
    JP UpdateKeypad

SECTION "Boot Vector", ROM0[$100]
    JR Main

    ; Fill the current address with zeros until $150
    ; This is useful for avoid overwritten the cartridge header 
    ds $150 - @, 0 

SECTION "Main", ROM0[$150]
Main:
    CALL EnableTime
    CALL LCDOff
    CALL SetupScreen
    CALL SetupSnakeDirection
    CALL SetupPalette
    CALL SetupLCD
    CALL EnableVBlank
    CALL EnableKeypad
    EI
    JP Sleep

SetupPalette:
    ld a, %11100100
    ld [rBGP], a
    ld [rOBP0], a
    RET

SetupSnakeDirection:
    LD A, SNAKE_MOVING_DEFAULT
    LD [MOVING], A
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

UpdateKeypad:
    RETI

SECTION "VARIABLES", WRAM0

MOVING: DS 1

SECTION "DATA", ROM0

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

