;

.MODEL small

extrn des4:near

.STACK

.DATA
ndir db 50 dup(?)

.CODE
main:   mov ax, @data
        mov ds, ax
        mov es, ax

        mov dl, 0
        mov si, offset ndir
        mov ah, 47h
        int 21h
        jc error

        ;desplegar directorio actual
        push offset ndir
        call despc
        add sp, 02
        .exit 0

 error: mov dx, ax
        call des4
        .exit 1

;------
despc:  push bp
        mov bp, sp
        mov ah, 02h

        cld
        mov si, [bp+4]
 dcl:   lodsb
        cmp al, 0
        je dcs
        mov dl, al
        int 21h
        jmp dcl

        mov sp, bp
 dcs:   pop bp
        ret
;------
end