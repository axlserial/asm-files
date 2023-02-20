; Programa que tiene una función 'fun' que recibe dos parametros, llama dos funciones, una para sumar
; y otra para restar. Finalmente calculará la diferencia entre estos resultados y la devolverá.

.MODEL SMALL

extrn leeDec:near               ; Func que lee un núm base 10
extrn desDec:near               ; Func que muestra un núm base 10
extrn reto:near                 ; Muestra retorno de carro

.STACK
.DATA

.CODE
main:   mov ax, @data           ; obtiene dirección de DATA
        mov ds, ax              ; la guarda en 'ds'
        ;mov es, ax             ; para usar DI, SI

        call leeDec             ; lee el 1er núm base 10
        call reto               ; retorno de carro
        push ax                 ; guarda el núm en la pila
        call leeDec             ; lee el 2do núm
        call reto               ; retorno de carro
        push ax                 ; guarda el núm en la pila

        ; estos núms guardados son los dos parámetros de la función

        call fun                ; se llama a la función con sus parámetros cargados
        add sp, 04              ; se libera el espacio de los parámetros

        mov dx, ax              ; guarda en 'dx' el resultado de la función
        call desDec             ; lo muestra en pantalla

        .exit 0

;---------------------

fun:    push bp                 ; se resguarda el valor de 'bp'
        mov bp, sp              ; copiamos en 'bp' a lo que apunta 'sp'
        sub sp, 02              ; reservamos espacio para una variable local (res. suma)
        mov ax, [bp+6]          ; copiamos a 'ax' el valor del parámetro 1 
        push ax                 ; se guarda en la pila
        mov ax, [bp+4]          ; copiamos a 'ax' el valor del parámetro 2
        push ax                 ; se guarda en la pila

        ; estos dos valores guardados, son los parámetros de la llamada a la función 'suma'

        call suma               ; se hace el cálculo de la suma de los parámetros
        add sp, 04              ; se libera el espacio de los parámetros
        mov [bp-2], ax          ; el resultado se guarda en la variable local

        mov ax, [bp+6]          ; copiamos a 'ax' el valor del parámetro 1 
        push ax                 ; se guarda en la pila
        mov ax, [bp+4]          ; copiamos a 'ax' el valor del parámetro 2
        push ax                 ; se guarda en la pila

        ; estos dos valores guardados, son los parámetros de la llamada a la función 'resta'

        call resta              ; se hace el cálculo de la resta de los parámetros
        add sp, 04              ; se libera el espacio de los parametros

        ; resultados de las operaciones en [bp-2] (variable local) de la suma y en 'ax' de la resta
        
        sub [bp-2], ax          ; se obtiene la diferencia entre los resultados ([bp-2] = [bp-2] - ax)
        mov ax, [bp-2]          ; se copia el resultado final en 'ax'

        mov sp, bp              ; se copia en 'sp' a lo que apuntaba originalmente 
        pop bp                  ; 'bp' recupera su valor original
        ret

;---------------------

suma:   push bp                 ; se guarda el valor de 'bp'
        mov bp, sp              ; copia en 'bp' a lo que apunta 'sp'

        mov ax, [bp+6]          ; guarda en 'ax' el valor del 1er parámetro
        add ax, [bp+4]          ; se suma ese valor con el 2do parámetro

        mov sp, bp              ; se regresa el valor original de 'sp'
        pop bp                  ; 'bp' recupera su valor original
        ret

;---------------------

resta:  push bp                 ; se guarda el valor de 'bp'
        mov bp, sp              ; copia en 'bp' a lo que apunta 'sp'

        mov ax, [bp+6]          ; guarda en 'ax' el valor del 1er parámetro
        sub ax, [bp+4]          ; se resta a ese valor el del 2do parámetro

        mov sp, bp              ; se regresa el valor original de 'sp'
        pop bp                  ; 'bp' recupera su valor original
        ret

end