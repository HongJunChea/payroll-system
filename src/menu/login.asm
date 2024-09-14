
login_menu proc
;------------------------------------------LOGIN MODULE-----------------------------------------------------
	puts LOGIN_MSG
	puts LOGIN2

	ask_id:
		xor ax, ax ; IF JUMP BACK AGAIN,CLEAR THE PREVIOUS AX DATA
		puts PROMPT_PASS

;--------------------------------------LET USER ENTER ID----------------------------------------------------
	xor cx, cx
	mov cl, .user_id_length
	lea di, .user_id_input

	ACCEPT_ID:
		input_char_no_echo
		stosb

		putc "*"

		loop ACCEPT_ID

;----------------------------------CHECK AND COMPARE ID ENTERED-------------------------------------------------------

	strcmp .user_id_input .correct_id .user_id_length
	putc 10
	je VAL_MSG

	INV_MSG:                        ;DISPLAY MESSAGE IF ID INVALID
		puts INVALID_PASS
		jmp ASK_ID

	VAL_MSG:                        ;DISPLAY MESSAGE IF ID VALID
		puts INVALID_PASS
		ret

login_menu endp
