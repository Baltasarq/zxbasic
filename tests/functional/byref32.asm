	org 32768
__START_PROGRAM:
	di
	push ix
	push iy
	exx
	push hl
	exx
	ld hl, 0
	add hl, sp
	ld (__CALL_BACK__), hl
	ei
	jp __MAIN_PROGRAM__
__CALL_BACK__:
	DEFW 0
ZXBASIC_USER_DATA:
	; Defines USER DATA Length in bytes
ZXBASIC_USER_DATA_LEN EQU ZXBASIC_USER_DATA_END - ZXBASIC_USER_DATA
	.__LABEL__.ZXBASIC_USER_DATA_LEN EQU ZXBASIC_USER_DATA_LEN
	.__LABEL__.ZXBASIC_USER_DATA EQU ZXBASIC_USER_DATA
_y:
	DEFB 00, 00, 00, 00
ZXBASIC_USER_DATA_END:
__MAIN_PROGRAM__:
	ld hl, 0
	ld b, h
	ld c, l
__END_PROGRAM:
	di
	ld hl, (__CALL_BACK__)
	ld sp, hl
	exx
	pop hl
	exx
	pop iy
	pop ix
	ei
	ret
_test:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	push hl
	ld de, 0
	ld hl, 0
	ld bc, 4
	call __PISTORE32
	ld l, (ix-4)
	ld h, (ix-3)
	ld e, (ix-2)
	ld d, (ix-1)
	ld bc, 4
	call __PISTORE32
	ld hl, (_y)
	ld de, (_y + 2)
	ld bc, 4
	call __PISTORE32
	ld h, (ix+5)
	ld l, (ix+4)
	call __ILOAD32
	ld (_y), hl
	ld (_y + 2), de
_test__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
	;; --- end of user code ---
#line 1 "/zxbasic/src/arch/zx48k/library-asm/iload32.asm"
	; __FASTCALL__ routine which
	; loads a 32 bits integer into DE,HL
	; stored at position pointed by POINTER HL
	; DE,HL <-- (HL)
__ILOAD32:
		ld e, (hl)
		inc hl
		ld d, (hl)
		inc hl
		ld a, (hl)
		inc hl
		ld h, (hl)
		ld l, a
		ex de, hl
		ret
#line 51 "byref32.bas"
#line 1 "/zxbasic/src/arch/zx48k/library-asm/pistore32.asm"
#line 1 "/zxbasic/src/arch/zx48k/library-asm/store32.asm"
__PISTORE32:
			push hl
			push ix
			pop hl
			add hl, bc
			pop bc
__ISTORE32:  ; Load address at hl, and stores E,D,B,C integer at that address
			ld a, (hl)
			inc hl
			ld h, (hl)
			ld l, a
__STORE32:	; Stores the given integer in DEBC at address HL
			ld (hl), c
			inc hl
			ld (hl), b
			inc hl
			ld (hl), e
			inc hl
			ld (hl), d
			ret
#line 2 "/zxbasic/src/arch/zx48k/library-asm/pistore32.asm"
	; The content of this file has been moved to "store32.asm"
#line 52 "byref32.bas"
	END
