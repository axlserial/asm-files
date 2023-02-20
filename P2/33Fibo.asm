; Programa que realiza el cálculo hasta el valor n de la sucesión de Fibonacci
;   * solamente obtiene hasta el término 24 'Fibonacci(24)' *

.MODEL small

extrn leeDec:near               ; Func que lee un número en base 10
extrn desDec:near               ; Func que muestra un número base 10
extrn reto:near                 ; Muestra un retorno de carro

.STACK
.DATA

.CODE
main:   mov ax, @data
        mov ds, ax

        call leeDec             ; lee el n valor a obtener de fibonacci
        call reto               ; retorno de carro
        push ax                 ; se guarda como parámetro

        call fibo               ; se calcula ese n valor
        add sp, 02              ; se libera el espacio en memoria de n

        mov dx, ax              ; copia en 'dx' el resultado
        call desDec             ; se muestra en pantalla

        .exit 0

;---------------------

fibo:   push bp                 ; se guarda el valor de 'bp'
        mov bp, sp              ; se copia en 'bp' a lo que apunta 'sp'
        sub sp, 02              ; espacio para una variable local

        ; condiciones de salida
        mov ax, [bp+4]          ; copia el parámetro en 'ax'
        cmp ax, 02              ; cmp el núm con 2
        jg f_si                 ;   sí es mayor, salta a 'f_si'
        cmp ax, 00              ; cmp el núm con 0
        jg f_ma                 ;   sí es mayor, salta a 'f_ma'
        mov ax, 00              ; asigna 0 a 'ax'
        jmp f_sa                ; salta a 'f_sa'
 f_ma:  mov ax, 01              ; asigna un 1 a 'ax'
        jmp f_sa                ; salta a 'f_sa'

        ; recursividad
 f_si:  dec ax                  ; decrementa en uno
        push ax                 ; lo guarda como parámetro
        call fibo               ; llamada recursiva 
        add sp, 02              ; libera espacio del parámetro
        mov [bp-2], ax          ; guarda el resultado en variable local
        mov ax, [bp+4]          ; copia a 'ax' el parámetro actual
        sub ax, 02              ; le resta 2
        push ax                 ; lo guarda como parámetro
        call fibo               ; llamada recursiva
        add sp, 02              ; libera espacio del parámetro
        add ax, [bp-2]          ; al resultado, le suma el res anterior 

        ; el resultado se encuentra en 'ax'

 f_sa:  mov sp, bp              ; regresa el valor original de 'sp'
        pop bp                  ; 'bp' recupera su valor original
        ret

;---------------------
end