; Programa que multiplica dos números de 16 bits
; resultado: número de 32 bits (DX-AX) 
; DX = parte alta, AX = parte baja

.MODEL SMALL

extrn lee4:near
extrn des4:near
extrn espa:near
extrn reto:near

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene la dirección de DATA
        mov ds, ax              ; la guarda en 'ds'

        call lee4               ; lee el 1er núm de 4 digitos (16 bits)
        call espa               ; espacio en pantalla
        mov bx, ax              ; guarda el núm en 'bx'
        call lee4               ; lee el 2do núm de 4 digitos
        call reto               ; retorno de carro
        mul bx                  ; esta implicito que el otro es AX (AX * BX) 
        mov bx, ax              ; guarda en 'bx' la parte baja del núm 
        call des4               ; se muestra la parte alte del núm (se encuentra en 'dx')
        mov dx, bx              ; mueve a 'dx' la parte baja del núm
        call des4               ; muestra la parte baja del núm

        .exit 0
end