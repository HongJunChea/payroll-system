.model small
.stack 100
.data
	INP_USERID db 10 dup(?)

	;NEW LINE
	nl db 0ah,0dh,'$'

	;LOGIN MESSAGE
	LOGIN1 db 10,13,'Welcome to the payroll system!!!!!$'
	LOGIN2 db 10,13,'------------------------------------$'
	ID_ENT db 10,13,'Please enter your ID: $'	

	;INVALID ID MESSAGE
	INVALID db 'Invalid ID, please try again!!!$'

	;VALID ID MESSAGE
	VALID db 'Valid ID, you may proceed to MENU!!!$'

	
.code
main proc far
	mov ax,@data
	mov ds,ax

;------------------------------------------LOGIN MODULE-----------------------------------------------------
	mov ah,09h
	lea dx,LOGIN1
	int 21h

	mov ah,09h
	lea dx,nl
	int 21h

	mov ah,09h
	lea dx,LOGIN2
	int 21h

ASKID:
	mov ah,09h
	lea dx,nl
	int 21h	

	mov ah,09h
	lea dx,ID_ENT
	int 21h

	mov ax,0                 ;AS IF JUMP BACK AGAIN,CLEAR THE PREVIOUS AX DATA
	mov bx,0
	mov cx,7

;--------------------------------------LET USER ENTER ID----------------------------------------------------

ACCEPT_ID:
	mov ah,07h
	int 21h
	mov INP_USERID[bx],al

	mov ah,02h
	mov dl,'*'
	int 21h
	
	inc bx
loop ACCEPT_ID

	mov bx,0

;----------------------------------CHECK AND COMPARE ID ENTERED-------------------------------------------------------

	cmp INP_USERID[bx],'2'    ;COMPARE NUMBER ENTERED WITH CORRECT ID NUMBER
	jne INV_MSG               ;JUMP TO INVALID ID MESSAGE
	inc bx

	cmp INP_USERID[bx],'2'
	jne INV_MSG
	inc bx

	cmp INP_USERID[bx],'0'
	jne INV_MSG
	inc bx

	cmp INP_USERID[bx],'3'
	jne INV_MSG
	inc bx

	cmp INP_USERID[bx],'8'
	jne INV_MSG
	inc bx

	cmp INP_USERID[bx],'7'
	jne INV_MSG
	inc bx

	cmp INP_USERID[bx],'6'
	jne INV_MSG
	inc bx
	jmp VAL_MSG             ;JUMP TO VALID ID MESSAGE

INV_MSG:                        ;DISPLAY MESSAGE IF ID INVALID
	mov ah,09h
	lea dx,nl
	int 21h

	mov ah,09h
	lea dx,nl
	int 21h
	
	mov ah,09h
	lea dx,INVALID
	int 21h
	jmp ASKID


VAL_MSG:                        ;DISPLAY MESSAGE IF ID VALID
	mov ah,09h
	lea dx,nl
	int 21h
	
	mov ah,09h
	lea dx,VALID	
	int 21h
	
	

	

EXIT:
	mov ax,4c00h
	int 21h
main endp
end main