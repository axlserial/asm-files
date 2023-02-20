; Programa que muestra el uso de las instrucciones 'CLD' y 'STOSB' para uso con arreglos
; Rellena un arreglo de un solo simbolo y lo muestra en pantalla

.MODEL small

extrn des2:near
extrn espa:near

.STACK

.DATA
arreglo db 20 dup(?)      ; arreglo sobre el que se iterará

.CODE
main:   mov ax, @data
        mov ds, ax                  ; segmento de datos
        mov es, ax                  ; segmento extra

        ; guardado de datos en arreglo
        mov cx, 20                  ; repeticiones
        mov di, offset arreglo      ; apuntador a arreglo (para escribir)
        cld                         ; indica autoincremento
        mov al, 0Fh                 ; dato a ingresar al arreglo n veces
        rep stosb                   ; sustituye a 'loop':
                                    ;   repite la instrucción la cantidad en 'cx'

        ; muestra como quedó el arreglo
        mov cx, 20                  ; repeticiones
        mov si, offset arreglo      ; apuntador a arreglo (para leer)
        cld                         ; indica autoincremento (despues de 'lodsb')
 cicl1: lodsb                       ; al = [si]; si++
        mov dl, al
        call des2                   ; muestra el núm
        call espa                   ; espacio
        loop cicl1                  ; repite el proceso

        .exit 0


end