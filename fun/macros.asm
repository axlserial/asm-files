; include ..\fun\macros.asm


; Macro que muestra un simbolo n veces.
; Recibe: Letra (Simbolo a mostrar en pantalla)
;         Repe  (Cantidad de veces a repetirse)
repeletra macro letra, repe
local rls
        pusha               ; respalda registros de uso general
        mov ah, 02h         ; servicio que muestra un char
        mov dl, letra       ; letra (símbolo) a mostrarse
        mov cx, repe        ; cant de veces a repetirse
rls:    int 21h             ; muestra el símbolo
        loop rls            ; repite las n veces
        popa                ; recupera los registros
endm

;---------------------

; Macro que imprime una cadena en pantalla
; Recibe: cadena (cadena a imprimir)
print macro cadena
local dbcad, dbfin, salta
        pusha                   ; respalda registros de uso general
        push ds                 ; respalda 'ds'
        mov dx, cs              ; copia direc de seg de datos a 'dx'
        mov ds, dx              ; copia esa direc a 'ds'
        mov dx, offset dbcad    ; copia direc de la cadena en 'dx'
        mov ah, 09h             ; servicio para mostrar una cadena
        int 21h                 ; muestra la cadena en pantalla
        jmp salta               ; salta al fin del macro
 dbcad  db cadena               ;       GUARDA EN MEMORIA LA CADENA
 dbfin  db '$'                  ;       DELIMITADOR DE FIN DE CADENA
 salta: pop ds                  ; restaura el valor original de 'ds'
        popa                    ; restaura valor original de registros
endm