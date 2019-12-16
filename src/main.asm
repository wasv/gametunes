;; -*- mode: rgbds; -*-
INCLUDE "hardware.inc"
INCLUDE "engine.inc"
INCLUDE "gfx.inc"

; rst vectors are currently unused
SECTION "rst00",ROM0[0]
    ret

SECTION "rst08",ROM0[8]
    ret

SECTION "rst10",ROM0[$10]
    ret

SECTION "rst18",ROM0[$18]
    ret

SECTION "rst20",ROM0[$20]
    ret

SECTION "rst30",ROM0[$30]
    ret

SECTION "rst38",ROM0[$38]
    ret

SECTION "vblank",ROM0[$40]
    reti
SECTION "lcdc",ROM0[$48]
    reti
SECTION "timer",ROM0[$50]
    reti
SECTION "serial",ROM0[$58]
    reti
SECTION "joypad",ROM0[$60]
    reti

SECTION "romheader",ROM0[$100]
    nop
    jp _start

SECTION "start",ROM0[$150]

_start:
    nop
    di
    ld sp, $fffe

; Starts on Bank 1 for tiles and pallettes.

; Disable LCD during initial VRAM writes.
    ld a, [rLCDC]
    res 7, a
    ld [rLCDC], a

; Reset pallete
    ld a, %11100100
    ld [rBGP], a
    ld [rOBP0], a

; Setup Pallette
    ld hl, BGPal
    ld a, $00
    call loadBGPal

    ld hl, BGPalAlt
    ld a, $08
    call loadBGPal

; Reset scrolling
    ld a, 0
    ld [rSCX], a
    ld [rSCY], a

; Turn off sound
    ld [rNR52], a

    ld hl, TileStart
    ld de, _VRAM+$200  ; Font starts at $8200
    ld bc, TileEnd - TileStart
    call memcpy

; Reenable LCD after VRAM writes.
    ld a, [rLCDC]
    set 7, a
    ld [rLCDC], a

; Switch to Bank 2 for sound fns.

    ld a,$02
    ld [rROMB0],a
    call main
    halt


SECTION "main", ROMX,BANK[2]
main:
.numBegin
    ld de, 0 ; digit offset
    ld c, tiles_number ; tile base
.numLoop
    ld a, e
REPT 4
    srl a
ENDR
    ld hl, _SCRN0
    add a, c
    add hl, de
    wait_lcd
    ld [hl], a
    
    ld a, e
    and $0f
    ld hl, _SCRN0+$20 ; screen location
    add a, c
    add hl, de
    wait_lcd
    ld [hl], a
    
    inc e
    ld a, e
    cp $20
    jr nz, .numLoop

.animBegin
    ld a, 0
    ld [rSCX], a
    ld [rSCY], a
.animLoop
    wait_div 8, 7
    wait_lcd
    ld [rSCX], a
    inc a
    jp .animLoop
    ret

