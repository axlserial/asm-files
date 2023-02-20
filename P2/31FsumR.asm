; Programa que tiene una función 'sumaR' que recibe un parámatro n (número)
; y hace una suma recursiva desde 1 hasta n

.MODEL SMALL

extrn leeDec:near               ; Func que lee un número en base 10
extrn desDec:near               ; Func que muestra un número base 10
extrn reto:near                 ; Muestra un retorno de carro

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene dirección de DATA
        mov ds, ax              ; la guarda en 'ds'
        ;mov es, ax             ; para usar DI, SI

        call leeDec             ; lee el número para la suma
        call reto               ; retorno de carro
        push ax                 ; guarda el parámetro de la función en la pila
        call sumaR              ; realiza la suma recursiva
        add sp, 02              ; libera el espacio del parámetro
        mov dx, ax              ; guarda el resultado en 'dx'
        call desDec             ; lo muestra en pantalla

        .exit 0

;---------------------

sumaR:  push bp                 ; se guarda el valor de 'bp'
        mov bp, sp              ; se copia en 'bp' a lo que apunta 'sp'

        ; condición de salida
        mov ax, [bp+4]          ; copia el parámetro en 'ax'
        cmp ax, 01              ; cmp el parámetro (número) con un 1
        jle sr_s                ;       sí el núm es menor o igual, salta a 'sr_s'

        ; recursividad
        dec ax                  ; decrementa en 1 el valor del número
        push ax                 ; se guarda en la pila como parámetro para la llamada recursiva
        call sumaR              ; llamada recursiva a 'sumaR' con el nuevo parámetro
        add sp, 02              ; terminada la llamada, se libera el espacio del parámetro
        add ax, [bp+4]          ; al resultado, se le suma el parámetro actual de la llamada

        ; el resultado de la llamada ya está en 'ax'

 sr_s:  mov sp, bp              ; se regresa el valor original de 'sp'
        pop bp                  ; 'bp' recupera su valor original
        ret

end