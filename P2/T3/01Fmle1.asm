; Programa que muestra el uso de la macro 'mlee1' para lectura de
; un número de 1 digito

.MODEL small

extrn des1:near
extrn reto:near

.STACK

.DATA
numero db ?                 ; variable para guardar el núm

.CODE
;---------------------

; Macro que lee un número de un dígito hex
; y lo guarda en el parámetro 'num'
; Recibe: num (lugar dónde guardar el número)
mlee1 macro num
local sig
        push ax             ; respalda 'ax'
        mov ah, 01h         ; serv que lee un char
        int 21h             ; lee el char
        sub al, 30h         ; de ASCII a valor núm
        cmp al, 09h         ; comp sí 'al' == num ó letra
        jle sig             ;      si es núm salta a 'sig'
        sub al, 07h         ; resta 07h 
        cmp al, 0Fh         ; comp sí 'al' == Mayús ó Minús
        jle sig             ;      si es Mayús salta a 'sig'
        sub al, 20h         ; resta 20h si es Minús
 sig:   mov num, al         ; guarda en 'num' el resultado
        pop ax              ; recupera 'ax'
endm

;---------------------

main:   mov ax, @data
        mov ds, ax

        mlee1 numero        ; lee y lo guarda en variable
        call reto           ; retorno de carro
        mov dl, numero      ; copia el núm en 'dl'
        call des1           ; lo muestra en pantalla

        .exit 0
end