; Programa que muestra el uso de un ciclo para mostrar la cadena 5 veces

.MODEL SMALL
.STACK
.DATA
    cadena db "Hola, mundo", 0Dh, 0Ah, 24h
.CODE
main:
        mov ax, @data               ; Obtiene la dirección de DATA (segmento de datos)
        mov ds, ax                  ; y ponerlo en el registro DS
        mov ah, 09h                 ; Servicio para desplegar cadena
        mov dx, offset cadena       ; cadena a mostrar
        mov cx, 05h                 ; cantidad de veces a mostrar
 salto: int 21h                     ; muestra la cadena
        loop salto                  ; repite la cantidad de veces
        .exit 0                     ; Equivalente a int 21h servicio 4ch
end main                            ; Podria requerir "end main"
