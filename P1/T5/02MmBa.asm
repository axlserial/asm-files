; programa que lee letras y muestra 'Mayuscula' o 'Minuscula' en pantalla hasta que se oprima 'space'

.MODEL SMALL
.STACK

.DATA
mayus db " Mayuscula", 0Ah, 24h
minus db " Minuscula", 0Ah, 24h

.CODE
main:   mov ax, @data               ; obtiene la dirección de DATA
        mov ds, ax                  ; se guarda en 'ds'
 ini:   mov ah, 01h                 ; servicio para leer un caracter
        int 21h                     ; se lee el caracter
        cmp al, 20h                 ; compara su valor con el ASCII del espacio
        je salir                    ;   si se introdujo un espacio, termina
        cmp al, 5Ah                 ; compara el valor del caracter con el ASCII de 'Z'
        jle mayor                   ;   si es menor o igual, es letra mayuscula y salta
        mov dx, offset minus        ; si es mayor, se pone en 'dx' la cadena 'Minuscula'
        jmp une                     ; salta a la linea de unión
 mayor: mov dx, offset mayus        ; pone en 'dx' la cadena 'mayuscula'
 une:   mov ah, 09h                 ; servicio para mostrar una cadena
        int 21h                     ; muestra la cadena adecuada en pantalla
        jmp ini                     ; repite el proceso hasta que entre un espacio
 salir: .exit 0
end