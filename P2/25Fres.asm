; Programa que hace una resta entre dos números de 2 digitos (8 bits)
; Muestra resultados tanto positivos y negativos

.MODEL SMALL

extrn lee2:near
extrn des2:near
extrn espa:near
extrn reto:near

.STACK

.DATA
negativo db "Negativo: ", 24h           ; Muestra la cadena en caso de que sea un resultado negativo

.CODE
main:   mov ax, @data                   ; obtiene dirección de DATA
        mov ds, ax                      ; La guarda en 'ds'

        call lee2                       ; lee el 1er núm
        call espa                       ; espacio en pantalla
        mov dl, al                      ; guarda el 1er núm en 'dl'
        call lee2                       ; lee el 2do núm
        call reto                       ; retorno de carro
        sub dl, al                      ; hace la resta (1er - 2do núm)
        mov bl, dl                      ; hace una copia del resultado en 'bl'
        and bl, 10000000b               ; verifica si el bit de signo negativo está encendido (último de más a la izq)
        jns desp                        ;       si el resultado no fué negativo, salta a 'desp'
        
        push dx                         ; guarda el valor de 'dx' en la pila
        mov ah, 09h                     ; servicio para deplegar una cadena
        mov dx, offset negativo         ; mensaje que indica número negativo
        int 21h                         ; muestra el mensaje
        pop dx                          ; recupera el valor original de 'dx'
 
 desp:  call des2                       ; muestra el resultado en pantalla

        .exit 0
end