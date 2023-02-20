; Programa que demuestra el uso de las macros

.MODEL small

extrn desDec:near

.STACK
.DATA

.CODE

; macro que recibe dos registros, direc de mem, variables, etc..
; y realiza la instrucción indicada (suma)
suma macro gato, perro
        add gato, perro
endm

multi macro recibe, fac1, fac2
        mov al, fac1
        mov bl, fac2
        mul bl
        mov recibe, ax
endm

main:   mov ax, @data
        mov ds, ax

        ;mov al, 4
        ;mov bl, 3
        ;suma al bl
        multi dx 4 3
        call desDec

        .exit 0

end