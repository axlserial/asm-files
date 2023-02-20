; Programa que invierte el número de 2 digitos (8 bits) introducido
; positivo -> negativo, o viceversa

.MODEL SMALL

extrn lee2:near
extrn des2:near
extrn dbin8:near
extrn reto:near

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene dirección de DATA
        mov ds, ax              ; La guarda en 'ds'

        call lee2               ; lee el números
        mov dl, al              ; lo guarda en 'dl'
        call reto               ; retorno de carro
        call dbin8              ; muestra el número en binario
        call reto               ; retorno de carro

        not al                  ; invierte los bits del número (0 -> 1 || 1 -> 0)
        mov dl, al              ; guarda el número invertido en 'dl'
        call dbin8              ; lo muetra en binario
        call reto               ; retorno de carro
        inc al                  ; incrementa en 1 el número para completarlo
        mov dl, al              ; mueve el número en 'dl'
        call dbin8              ; muestra el número invertido correcto en binario
        call reto               ; retorno de carro
        mov dl, al              ; vuelve a poner el número en 'dl'
        call des2               ; lo muestra en hexadecimal

        .exit 0
end