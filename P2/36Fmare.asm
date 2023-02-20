; Programa que demuestra un uso más grande de macros

.MODEL small

.286
extrn lee2:near

.STACK
.DATA

.CODE

; Macro que recibe dos valores:
;   Letra: Simbolo a mostrar en pantalla
;   Repe: Cantidad de veces a repetirse
repeletra macro letra, repe
local rls
        pusha               ; respalda todos los registros
        mov ah, 02h         ; servicio que muestra un char
        mov dl, letra       ; letra (símbolo) a mostrarse
        mov cx, repe        ; cant de veces a repetirse
rls:    int 21h             ; muestra el símbolo
        loop rls            ; repite las n veces
        popa                ; recupera los registros
endm

main:   mov ax, @data
        mov ds, ax

        call lee2           ; lee número de 2 digitos
        repeletra '-' 03h   ; muestra '-' 3 veces
        call lee2           ; lee número de 2 digitos
        repeletra '-' 03h   ; muestra '-' 3 veces
        call lee2           ; lee número de 2 digitos

        .exit 0

end