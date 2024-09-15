; Get cursor current position
; Params
;   bh: page number
; Returns
;   ch: start scan line
;   cl: end scan line
;   dh: cursor row
;   dl: cursor col
get_cursor_pos proc

    push ax

    xor al, al
    mov ah, 03h
    int 10h

    pop ax

get_cursor_pos endp


; Set cursor position
; Params:
;   bh: page number
;   dh: cursor row
;   dl: cursor col
set_cursor_pos proc

    push ax

    xor al, al
    mov ah, 02h
    int 10h

    pop ax

set_cursor_pos endp


; Scroll down the screen given the number of lines
; Params:
;   al: lines to scroll, 0 = clear
;   bh: background color and foreground color. https://en.wikipedia.org/wiki/BIOS_color_attributes
;
;   if al = 0:
;   ch: upper row number
;   cl: left column number
;   dh: lower row number
;   dl: right column number
scroll_down proc

    push ax

    mov ah, 06h
    int 10h

    pop ax

scroll_down endp


; Clears the current screen
; Params:
;
; Returns:
;
clear_screen proc

    push ax
    push cx
    push dx

    mov al, 0
    call scroll_down

    pop dx
    pop cx
    pop ax

clear_screen endp
