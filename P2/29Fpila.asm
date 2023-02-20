; Programa que demuestra el uso de la pila para pasar parámetros a funciones

.MODEL SMALL

extrn desDec:near           ; Func que muestra un número en base 10
extrn reto:near             ; Func que muestra un retorno de carro

.STACK
.DATA

.CODE
main:   mov ax, @data
        mov ds, ax

        mov ax, 11          ; primer número a sumar (en base 10 todos)
        push ax             ; se guarda en la pila como primer parámetro de la función [bp+8]
        mov ax, 68          ; segundo número a sumar
        push ax             ; se guarda en la pila como segundo parámetro de la función [bp+6]
        mov ax, 10          ; tercer número a sumar
        push ax             ; se guarda en la pila como tercer parámetro de la función [bp+4]
        call funcion        ; con los parametros listos, se llama a la función
        add sp, 06h         ; libera el espacio ocupado por los parametros de la función (2 bytes por cada uno, eran 3)
                            ;   restaura la pila sin extraer los datos, equivalente a hacer 'pop' tres veces

        mov dx, ax          ; copia a 'dx' el resultado regresado por la función
        call desDec         ; muestra el resultado en base 10
        .exit 0

funcion:
        push bp             ; respalda lo que apunta 'bp' 
        mov bp, sp          ; guarda en 'bp' a lo que apunta 'sp'
        sub sp, 02h         ; reserva espacio para 1 variable local

        mov ax, [bp+8]      ; guarda en 'ax' el valor del primer parámetro pasado por la pila
        add ax, [bp+4]      ; suma a 'ax' el valor del segundo parámetro pasado por la pila
        add ax, [bp+6]      ; suma a 'ax' el valor del tercer parámetro pasado por la pila
        mov [bp-2], ax      ; guarda el resultado en el espacio de la variable local
        mov ax, [bp-2]      ; regresa a 'ax' ese resultado guardado

        mov sp, bp          ; regresa a 'sp' lo que apuntaba originalmente
        pop bp              ; regresa a 'bp' lo que apuntaba originalmente
        ret

end