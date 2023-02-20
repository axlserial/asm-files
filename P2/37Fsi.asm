; Programa que muestra el uso de las instrucciones 'CLD' y 'LODSB' para uso con arreglos
; Muestra un arreglo de forma ascendente y descendente en pantalla

.MODEL small

extrn des2:near
extrn espa:near
extrn reto:near

.STACK

.DATA
arreglo db 01h, 02h, 03h, 04h, 05h      ; arreglo sobre el que se iterará

.CODE
main:   mov ax, @data
        mov ds, ax                  ; segmento de datos
        mov es, ax                  ; segmento extra

        ; uso de incremento
        mov cx, 05h                 ; itera 5 veces
        mov si, offset arreglo      ; apuntador a arreglo
        cld                         ; indica autoincremento (despues de 'lodsb')
 cicl1: lodsb                       ; al = [si]; si++
        mov dl, al
        call des2                   ; muestra el núm
        call espa                   ; espacio
        loop cicl1                  ; repite el proceso

        call reto

        ; uso de decremento
        mov cx, 05h                 ; itera 5 veces
        mov si, offset arreglo      ; apuntador a arreglo
        add si, 04h                 ; apuntador se posiciona en el ultimo elemento
        std                         ; indica autodecremento (despues de 'lodsb')
 cicl2: lodsb                       ; al = [si]; si--
        mov dl, al
        call des2                   ; muestra el núm
        call espa                   ; espacio
        loop cicl2                  ; repite el proceso

        .exit 0


end