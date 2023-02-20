; Programa que multiplica cuatro números de 8 bits esperando que el divisor no sea 0
; resultado: número de 16 bits

.MODEL SMALL

extrn lee2:near
extrn des4:near
extrn espa:near
extrn reto:near

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene dirección de DATA
        mov ds, ax              ; la guarda en 'ds'

        mov bx, 01h             ; valor inicial, acumulador del res
        mov cx, 04h             ; cantidad de núm a multiplicar
 ciclo: call lee2               ; lee un núm de 2 digitos (8 bits)
        mov ah, 0               ; pone un 0 en la parte alta del núm
        mul bx                  ; multiplica el res actual por el núm leido
        mov bx, ax              ; guarda el res de la mul en 'bx'
        call espa               ; espacio en pantalla
        loop ciclo              ; repite el proceso 4 veces

        call reto               ; retorno de carro
        mov dx, bx              ; guarda el res en 'dx'
        call des4               ; muestra el res en pantalla (núm 4 digitos - 16 bits)

        .exit 0
end