; Programa que muestra el uso de la macro 'mmayus' para convertir una letra
; minúscula en mayúscula

.MODEL small
.STACK

.DATA
letra db ?

.CODE
;---------------------

; Macro que recibe una letra y la convierte
; a mayúscula sí es minúscula, sí no, no hace nada
; Recibe: letra (la letra a convertir)
mmayus macro letra
local fin
        push ax             ; respalda 'ax'
        mov al, letra       ; copia la letra a 'al'
        cmp al, 5Ah         ; cmp con la 'Z'
        jle fin             ;   sí 'al' <= 'Z', salta a 'fin'
        sub al, 20h         ;   sí no, le resta 20h
        mov letra, al       ; copia la letra en el param
 fin:   pop ax              ; recupera 'ax'
endm

;---------------------

main:   mov ax, @data
        mov ds, ax

        mov bx, offset letra
        mov ah, 01h         ; serv lectura de char
        int 21h             ; lee la letra
        mov [bx], al        ; la copia a la variable
        mmayus [bx]         ; la convierte a mayús
        mov ah, 02h         ; serv impresión de char
        mov dl, ' '         ; espacio
        int 21h             ; imprime el espacio     
        mov dl, [bx]        ; letra mayúscula
        int 21h             ; la muestra en pantalla

        .exit 0
end