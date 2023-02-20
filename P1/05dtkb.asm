; Realiza operación de suma de dos num que lee de teclado

.MODEL SMALL
.STACK
.DATA
    datoa   db ?
    datob   db ?
    datores db ?
.CODE
main:
        mov ax, @data               ; Obtiene la dirección de DATA (segmento de datos)
        mov ds, ax                  ; y ponerlo en el registro DS

        mov ah, 01h                 ; para leer un caracter

        ; lee el primer número como ASCII y lo convierte a número
        int 21h      
        sub al, 30h
        mov datoa, al

        ; lee segundo número
        int 21h
        sub al, 30h
        mov datob, al
        
        ; mueve los números a registros 
        mov al, datoa
        mov bl, datob

        ; suma los valores, guarda el res. en 'datores' y convierte a ASCII        
        add al, bl
        mov datores, al
        add datores, 30h

        ; imprime el resultado
        mov ah, 02h
        mov dl, datores
        int 21h

        .exit 0   
end main
