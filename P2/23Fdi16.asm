; Programa que divide un número de 16 bits (4 digitos) entre uno de 8 bits (2 digitos)
; resultado: número de 8 bits y otro de 8 para residuo

; REVISAR

.MODEL SMALL

extrn lee2:near
extrn lee4:near
extrn des2:near
extrn des4:near
extrn espa:near
extrn reto:near

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene dirección de DATA
        mov ds, ax              ; La guarda en 'ds'

        call lee4               ; lee el núm de 16 bits
        call espa               ; espacio en pantalla
        mov dx, ax              ; guarda el dividendo en 'dx'
        
 repet: call lee2               ; lee el núm de 8 bits
        call reto               ; retorno de carro
        cmp al, 0h              ; cmp si el núm introducido es 0
        je repet                ; si es 0, salta a 'repet'
        
        call reto               ; retorno de carro
        mov bl, al              ; guarda el divisor en 'bl'
        mov ax, dx              ; mueve el dividendo a 'ax'
        div bl                  ; hace la división (AX / BL)
        mov dl, al              ; mueve el resultado a 'dl'
        call des2               ; muestra el resultado 
        call reto               ; retorno de carro
        mov dl, ah              ; mueve el residuo a 'dl'
        call des2               ; muestra el residuo

        .exit 0
end