; Programa que hace sumas con acarreo

.MODEL SMALL

.286
extrn des2:near
extrn reto:near
extrn espa:near

.STACK
.DATA

.CODE
main:   mov ax, @data
        mov ds, ax

        ; suma
        mov al, 0FEh
        add al, 01h
        push ax
        mov al, 00h
        adc al, 00h
        mov dl, al
        call des2
        pop dx
        call des2

        ; retorno de carro
        call reto

        ; resta
        mov al, 22h
        sub al, 23h
        push ax
        mov al, 01h
        sbb al, 00h
        mov dl, al
        call des2
        pop dx
        call des2


        .exit 0
end