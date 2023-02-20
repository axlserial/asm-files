; Programa que multiplica dos números de 8 bits
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

        call lee2               ; lee el primer núm de 2 digitos
        call espa               ; espacio en pantalla
        mov bl, al              ; guarda ese núm en 'bl'
        call lee2               ; lee el 2do núm de 2 digitos
        call reto               ; retorno de carro
        mul bl                  ; esta implicito que el otro es AL (AX * BX)
        mov dx, ax              ; pone el resultado en 'dx'
        call des4               ; despliega el núm res de 4 digitos

        .exit 0
end