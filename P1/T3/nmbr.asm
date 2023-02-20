; Programa que muestra mi nombre restandole una letra
.MODEL SMALL
.STACK
.DATA
    nombre db "Axel", 24h
.CODE
main:   mov ax, @data                   ; obtiene la dirección del segmento de datos 
        mov ds, ax                      ; la pone en el registro 'ds'

        mov cx, 04h                     ; ponemos como contador el tamaño del nombre
        mov dx, offset nombre           ; offset obtiene la dirección de 'nombre' y se guarda en 'dx'
        
 ciclo: mov ah, 09h                     ; servicio para desplegar una cadena
        int 21h                         ; desplegamos la cadena
        inc dx                          ; avanzamos a la siguiente letra del nombre
        mov bx, dx                      ; guardamos el nombre en 'dx'
        mov ah, 02h                     ; servicio para desplegar un caracter
        mov dl, 20h                     ; ponemos en 'dl' el ASCII para el espacio
        int 21h                         ; mostramos el espacio en pantalla
        mov dx, bx                      ; regresamos la cadena nombre a 'dx'
        loop ciclo                      ; repetimos todo el proceso hasta que cx == 0
        
        .exit 0
end main