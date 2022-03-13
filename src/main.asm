INCLUDE "src/utils/hardware.inc"

SNAKE_MOVING_RIGHT EQU 1
SNAKE_MOVING_LEFT EQU 2
SNAKE_MOVING_UP EQU 3
SNAKE_MOVING_DOWN EQU 4

SECTION "VBlank Interrupt", ROM0[$40]
VBLankInterrupt::
    JP UpdateSnake

SECTION "Boot Vector", ROM0[$100]
    JR Main

SECTION "Main", ROM0[$150]
Main:
    CALL SetupPalette
    CALL SetupScreen
    JP Wait

SetupPalette:
    ld a, %11100100
    ld [rBGP], a
    ld [rOBP0], a
    RET

SetupScreen:
    ld a, LCDCF_ON + LCDCF_OBJON + LCDCF_BG8000
    ld [rLCDC], a
    RET

Wait:
    JP Wait

UpdateSnake:
    RETI

SECTION "VARIABLES", WRAM0
MOVING: ds SNAKE_MOVING_RIGHT

SECTION "DATA", ROM0

SnakeTile: 
    INCBIN "tiles/snake.bin"
FruitTie:
    INCBIN "tiles/fruit.bin"

