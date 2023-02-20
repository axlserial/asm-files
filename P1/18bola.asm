; Programa que muestra una bola que se recorre de izquierda a derecha un n número de veces.

.MODEL SMALL
.STACK

.DATA
bola db "_________o_", 0Dh, 24h             ; Cadena que tiene a la bola que se recorrerá

.CODE
main:   mov ax, @data                       ; obtiene la dirección de DATA
        mov ds, ax                          ; y la guarda en 'ds'

        mov ah, 09h                         ; servicio que muestra una cadena en pantalla 
        mov cx, 05h                         ; la cantidad de veces que se repetirá el ciclo completo

 total: push cx                             ; guarda las veces que hace falta por repetirse el ciclo
        mov dx, offset bola                 ; pone la dirección inicial de la cadena bola en 'dx'

        mov cx, 08h                         ; se recorrerá 8 espacios a la izquierda
 ciclo: int 21h                             ; muestra la figura inicial
        inc dx                              ; se recorre un espacio a la izquierda
        call delay                          ; hace un delay en pantalla
        loop ciclo                          ; se repite hasta que se haya recorrido 8 espacios

        mov cx, 08h                         ; se recorrerá 8 espacios a la derecha
 cicl2: int 21h                             ; muestra la figura actual (la bola en el lado izquierdo)
        dec dx                              ; se recorre un espacio a la derecha
        call delay                          ; hace un delay en pantalla
        loop cicl2                          ; se repite hasta que se haya recorrido 8 espacios

        pop cx                              ; recupera de la pila la cantidad de ciclos faltantes
        loop total                          ; se repite las n veces señaladas
        .exit 0


; Realiza un retardo en pantalla
delay:  push cx                             ; Resguarda en la pila los datos del registro 'cx'
        mov cx, 0FFFFh                      ; Establece el núm FFFF como contador
 cic1:  push cx                             ; lo guarda en la pila
        mov cx, 00006h                      ; ciclo interno de contador con valor = 6
 cic2:  loop cic2                           ; se repite las 6 veces
        pop cx                              ; regresa el contador superior (FFFF)
        loop cic1                           ; realiza el ciclo las FFFF veces
        pop cx                              ; recupera de la pila el valor original de 'cx'
        ret

end