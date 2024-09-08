
login_menu proc
;------------------------------------------LOGIN MODULE-----------------------------------------------------
	puts LOGIN1
	puts LOGIN2

	ask_id:
		xor ax, ax ; IF JUMP BACK AGAIN,CLEAR THE PREVIOUS AX DATA
		puts ID_ENT

;--------------------------------------LET USER ENTER ID----------------------------------------------------
	xor cx, cx
	mov cl, user_id_length
	lea di, INP_USERID

	ACCEPT_ID:
		input_char_no_echo
		stosb

		putc "*"

		loop ACCEPT_ID

;----------------------------------CHECK AND COMPARE ID ENTERED-------------------------------------------------------

	strcmp inp_userid correct_id user_id_length
	putc 10
	je VAL_MSG

	INV_MSG:                        ;DISPLAY MESSAGE IF ID INVALID
		puts INVALID
		jmp ASK_ID

	VAL_MSG:                        ;DISPLAY MESSAGE IF ID VALID
		puts VALID
		ret

login_menu endp
