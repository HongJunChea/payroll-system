; Get cursor current position
; Params
;   ~~bh: page number~~ not used
; Returns
;   ch: start scan line
;   cl: end scan line
;   dh: cursor row
;   dl: cursor col
get_cursor_pos proc

    push ax
    push bx
    xor bx, bx

    xor al, al
    mov ah, 03h
    int 10h

    pop bx
    pop ax
    ret

get_cursor_pos endp


; Set cursor position
; Params:
;   ~~bh: page number.~~ not used
;   dh: cursor row
;   dl: cursor col
set_cursor_pos proc

    push ax
    push bx
    xor bx, bx

    xor al, al
    mov ah, 02h
    int 10h

    pop bx
    pop ax
    ret

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
    ret

scroll_down endp


; Clears the current screen
clear_screen proc

    push ax

    mov ah, 0   ; set video mode
    mov al, 3   ; https://mendelson.org/wpdos/videomodes.txt
    int 10h

    pop ax
    ret

clear_screen endp
