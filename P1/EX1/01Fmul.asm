; Programa que multiplica dos números hexadecimales de dos digitos

.MODEL SMALL

.286
extrn lee2:near                 ; Función externa que lee un núm hex de 2 digitos
extrn des2:near                 ; Función externa que muestra un núm de 2 digitos
extrn espa:near                 ; Función que muestra un espacio en pantalla

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene la direc de DATA
        mov ds, ax              ; la guarda en 'ds'

        call lee2               ; lee el 1er núm a multiplicar
        call espa               ; muestra un espacio en pantalla
        mov dh, al              ; coloca en 'dh' ese primer núm
        call lee2               ; lee el 2do núm a multiplicar
        call espa               ; muestra un espacio en pantalla
        mov dl, al              ; coloca en 'dl' ese segundo núm
        call multi              ; multiplica los números
        mov dl, al              ; coloca el resultado en 'dl'
        call des2               ; muestra el resultado en pantalla
        .exit 0


; Func que multiplica 2 núm hex y regresa el resultado
; Entrada: dh (1er núm), dl (2do núm)
; Salida: al
multi:  push cx                 ; resguarda los datos de 'cx'
        mov cl, dh              ; utiliza el 1er núm como contador
        mov ch, 0h              ; un cero para completar 'cx'
        mov al, 0h              ; colocamos un cero en 'al'
 sum:   add al, dl              ; sumamos a 'al' el 2do núm
        loop sum                ; repetimos según el 1er num
        pop cx                  ; recupera el valor original de 'cx'
        ret 

end