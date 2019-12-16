;; -*- mode: rgbds; -*-

; Map of offsets within tiles.bin
RSRESET
RSSET $20 ; tiles start at VRAM offset 0x20.

tiles_blank       RB  1
tiles_cursor      RB  1
tiles_beta        RB  1
tiles_rest        RB  1
tiles_notes       RB 12 ; Rest, then the 12 notes.
tiles_notes_end   RB  0

tiles_number      RB 16 ; 0-F at offset 10-1F.
tiles_number_end  RB  0

tiles_tempo       RB  8 ; notes A-G = note offset 0-7
tiles_tempo_end   RB  0

tiles_volume      RB  8 ; Progress bar animation.
tiles_volume_end  RB  0

; End of tile map
