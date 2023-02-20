; Programa que declare una cadena, y utilice el apuntador 'bx' para
; desplegar cada letra de la cadena hasta encontrar un espacio

.MODEL SMALL
.STACK

.DATA
arreglo db "Hola "
numeros db 01h, 02h, 03h, 04h, 05h, 00h

.CODE
main:   mov ax, @data                     ; obtiene la dirección de DATA (segm. de datos)
        mov ds, ax                        ; la pone en el registro 'ds'
        mov bx, offset arreglo            ; obtiene la direccón de 'arreglo' y la guarda en 'bx'
        mov ah, 02h                       ; servicio para mostrar un caracter
 vuel:  mov dl, [bx]                      ; pone en 'dl' a lo que apunta 'bx' en ese momento. como si fuera: arreglo[actual]
        cmp dl, 20h                       ; comp el caracter con el ASCII del espacio
        je salir                          ;      si el caracter es un espacio, salta a 'salir'
        int 21h                           ; muestra el caracter en pantalla
        inc bx                            ; avanza al sig espacio en el arreglo -> actual++
        jmp vuel                          ; realiza el proceso hasta que encuentre un espacio
 salir: .exit 0

 end