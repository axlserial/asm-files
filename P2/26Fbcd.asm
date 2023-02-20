; Programa que realiza una suma entre dos números decimales de 2 dígitos (8 bits)


; REVISAR


.MODEL SMALL

extrn lee2:near
extrn des2:near
extrn espa:near
extrn reto:near

.STACK
.DATA

.CODE
main:   mov ax, @data
        mov ds, ax

        call lee2
        call espa
        mov bl, al
        call lee2
        call reto
        
        push ax
        add al, bl
        daa                 ; ajusta el número a BCD (base 10)
        mov dl, al
        call des2
        pop ax

        call reto

        mov bh, al
        mov al, bl
        mov bl, bh
        sub al, bl
        das
        mov dl, al
        call des2

        .exit 0

end