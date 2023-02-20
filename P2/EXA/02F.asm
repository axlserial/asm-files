; Programa que muestra el uso de la macro mDisMem para mostrar el contenido de un arreglo en pantalla (en hex)

.MODEL small

extrn des2:near   ; Función que muestra 2 dígitos hex
extrn espa:near   ; Función que muestra un espacio

.STACK

.DATA
; Arreglo a mostrar
arreglo db 1h, 2h, 3h, 4h, 5h, 6h, 7h, 8h, 9h, 0Ah, 0Bh, 0Ch

.CODE

; Macro que muestra el contenido de un arreglo en pantalla
; Recibe la dirección del arr y su tamaño
mDisMem macro arr, tam
local ciclo
        push cx                 ; respalda 'cx'
        push bx                 ; respalda 'bx'
        push dx                 ; respalda 'dx'
        mov bx, offset arr      ; copia direcc en 'bx'
        mov cx, tam             ; copia tam en 'cx'
 ciclo: mov dl, [bx]            ; copia dato apuntado en 'dl'
        call des2               ; muestra el dato
        call espa               ; muestra un espacio
        inc bx                  ; avanza en el arreglo
        loop ciclo              ; repite hasta que cx == 0
        pop dx                  ; recupera 'dx'
        pop bx                  ; recupera 'dx'
        pop cx                  ; recupera 'dx'
endm

main:   mov ax, @data
        mov ds, ax

        mov ax, offset arreglo  ; copia direcc en 'ax'
        mov cx, 12              ; copia tam del arr en 'cx'
        mDisMem ax cx           ; llamada a macro

        .exit 0

end