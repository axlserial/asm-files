; programa que lee letras del teclado y las muestra en pantalla (excep. espacios) y termina si le llega una 'q'

.MODEL SMALL
.STACK
.DATA

.CODE
main:   mov ax, @data       ; obtiene la dirección de DATA
        mov ds, ax          ; se guarda en 'ds'
 ini:   mov ah, 08h         ; servicio para leer un caracter (sin eco)
        int 21h             ; leemos el caracter
        cmp al, 71h         ; comparamos el caracter y el ASCII de 'q'
        je salir            ;   si se introdujo una 'q' salta y termina el programa
        cmp al, 20h         ; comparamos el caracter y el ASCII del espacio
        je une              ;   si se introdujo un espacio no hace nada y reinicia
        mov ah, 02h         ; servicio para mostrar un caracter
        mov dl, al          ; ponemos el caracter en 'dl'
        int 21h             ; mostramos el caracter
 une:   jmp ini             ; regresamos al inicio pues no se introdujo una 'q'
 salir: .exit 0             ; termina en caso de que una 'q' entre
end