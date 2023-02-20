; Programa que obtiene el factorial de un número n y lo despliega en pantalla
;   * solamente sirve hasta 8! *

.MODEL SMALL

extrn lee1:near                 ; Func que lee el número
extrn desDec:near               ; Func que muestra un número base 10
extrn reto:near                 ; Muestra un retorno de carro

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene dirección de DATA
        mov ds, ax              ; la guarda en 'ds'

        mov ax, 00              ; inicializa 'ax' en 0
        call lee1               ; lee el núm a calcular su factorial
        call reto               ; retorno de carro
        push ax                 ; guarda el parámetro (número) en la pila

        call fact               ; se realiza el cálculo del factorial
        add sp, 02              ; se libera el espacio del parámetro
        
        mov dx, ax              ; copia a 'dx' el resultado
        call desDec             ; lo muestra en pantalla

        .exit 0

;---------------------

fact:   push bp                 ; se guarda el valor de 'bp'
        mov bp, sp              ; se copia en 'bp' a lo que apunta 'sp'
        
        ; condición de salida
        mov ax, [bp+4]          ; copia el parámetro en 'ax'
        cmp ax, 00              ; cmp el parámetro (número) con un 0
        jg fc_u                 ;       sí el núm es mayor, salta a 'fc_u'
        mov ax, 01              ; copia un 1 en 'ax'
        jmp fc_s                ; salta a 'fc_s'
 fc_u:  cmp ax, 01              ; cmp con un 1
        je fc_s                 ;       sí el núm es igual, salta a 'fc_s'

        ; recursividad
        dec ax                  ; decrementa en 1 el valor del número
        push ax                 ; parámetro para la llamada recursiva
        call fact               ; llamada recursiva a 'fact'
        add sp, 02              ; se libera el espacio del parámetro
        mov bx, [bp+4]          ; valor del parámetro de la llamada actual
        mul bx                  ; res de la llamada recursiva * parámetro

        ; el resultado ya está en 'ax'

 fc_s:  mov sp, bp              ; se regresa el valor original de 'sp'
        pop bp                  ; 'bp' recupera su valor original
        ret

;---------------------
end