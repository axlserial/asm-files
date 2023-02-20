; lee un número y muestra el resultado de hacer desplazamiento a la izquierda y derecha

.MODEL SMALL
.STACK
.DATA

.CODE
main:
        mov ax, @data               ; Obtiene la dirección de DATA (segmento de datos)
        mov ds, ax                  ; y ponerlo en el registro DS

        mov ah, 01h                 ; para leer un caracter

        ; lee como ASCII y lo convierte a número
        int 21h      
        sub al, 30h
        
        ; hace desplazamiento, convierte a ASCII y lo guarda en 'dl'
        shl al, 1                   ; el '1' es la cantidad de espacios que se mueven a la dirección indicada
        add al, 30h
        mov dl, al

        ; muestra el número desplazado
        mov ah, 02h
        int 21h

        .exit 0   
end main
