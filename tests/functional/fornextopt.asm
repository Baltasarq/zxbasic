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
_a:
	DEFB 00
ZXBASIC_USER_DATA_END:
__MAIN_PROGRAM__:
	ld a, 1
	ld (_a), a
	jp __LABEL0
__LABEL3:
__LABEL__lbl:
	ld hl, _a
	inc (hl)
__LABEL4:
	ld hl, _a
	inc (hl)
__LABEL0:
	xor a
	ld hl, (_a - 1)
	cp h
	jp nc, __LABEL3
__LABEL2:
	jp __LABEL__lbl
	;; --- end of user code ---
	END
