; Imprime el abecedario asi: A AB ABC ABCD ... ABCDE...XYZ

.MODEL SMALL
.STACK

.DATA
final db 'Z'
destino db 'A'
actual db ?

.CODE
main:   mov ax, @data           ; Obtiene la dirección de DATA (segmento de datos)
        mov ds, ax              ; y se guarda en 'ds'
        mov ah, 02h             ; servicio para mostrar un caracter
 reini: mov actual, 'A'         ; guardamos en 'actual' la letra inicial
        mov dl, actual          ; ponemos el valor de actual en 'dl'
 muest: int 21h                 ; mostramos la letra actual
        inc dl                  ; avanzamos una letra en actual
        cmp dl, destino         ; compara si actual es superior a destino
        jle muest               ;   si es menor, regresa a 'muest'
        inc destino             ; avanza una letra en destino
        mov actual, dl          ; movemos el nuevo actual
        mov dl, 20h             ; guardamos en 'dl' el ASCII del espacio
        int 21h                 ; mostramos el espacio en pantalla
        mov bl, destino         ; guardamos en 'bl' la letra 'destino'
        cmp final, bl           ; comparamos si 'final' es superior a 'destino'
        mov destino, bl         ; guardamos de nuevo la letra en 'destino'
        jge reini               ;   si final es mayor, regresamos
        .exit 0
end main