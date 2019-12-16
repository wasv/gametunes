;; -*- mode: rgbds; -*-

; Map of offsets withn tiles.bin
RSRESET
RSSET $20 ; tiles start at VRAM offset 0x20.
tiles_number      RB 16 ; numeric tiles 1-16 = offset 0-15
tiles_number_end  RB  0

tiles_tempo       RB  8 ; End of Song = tempo offset 0
tiles_eos         RB  0
tiles_tempo_end   RB  0

tiles_notes       RB  7 ; notes A-G = note offset 0-7
tiles_notes_end   RB  0

tiles_cursor      RB  1
tiles_play        RB  1
tiles_octave      RB  1
tiles_length      RB  1

tiles_status      RB  7 ; Progress bar animation.
tiles_status_end  RB  0

tiles_blank       RB  1
; End of tile map
