; Programa que muestra el típico Hola Mundo en pantalla

.MODEL SMALL
.STACK
.DATA
    cadena db "Hola, mundo!", 0Dh, 0Ah, 24h
.CODE
main:
    mov ax, @data               ; Obtiene la dirección de DATA (segmento de datos)
    mov ds, ax                  ; y ponerlo en el registro DS
    mov ah, 09h                 ; Servicio para desplegar cadena
    mov dx, offset cadena       ; cadena a mostrar
    int 21h                     ; muestra cadena en pantalla
    .exit 0                     ; Equivalente a int 21h servicio 4ch
end main                        ; Podria requerir "end main"
