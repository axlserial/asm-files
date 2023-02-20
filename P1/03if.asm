; Programa que muestra el funcionamiento de un "if" en ensamblador utilizando 'cmp' e instrucciones de salto
; Lee dos números y muestra cuál es el mayor

.MODEL SMALL
.STACK
.DATA
.CODE
main:
        mov ax, @data               ; Obtiene la dirección de DATA (segmento de datos)
        mov ds, ax                  ; y ponerlo en el registro DS
        ; inicio del codigo *
        mov ah, 01h                 ; Servicio para leer un caracter
        int 21h                     ; lee el primer numero, se guarda en 'al' porque es un solo caracter
        mov bl, al                  ; Respalda en bl el numero leido
        int 21h                     ; lee el segundo numero
        cmp bl, al                  ; compara los dos numeros leidos
        jg op1                      ; salta si el primer numero es mayor que el segundo
        mov dl, al                  ; si no, mueve el segundo numero a dl
        jmp op2                     ; salta a la instrucción de impresión
  op1:  mov dl, bl                  ; llega aqui si el primer numero es mayor
  op2:  mov ah, 02h                 ; se coloca en 'ah' la instrucción de impresión de un caracter
        int 21h                     ; imprime el numero mayor que anteriormente se almacenó en 'dl'
        mov ah, 4Ch                 ; se prepara para salir
        int 21h                     ; sale
        .exit 0                     ; Equivalente a int 21h servicio 4ch
end                                 ; Podria requerir "end main"
