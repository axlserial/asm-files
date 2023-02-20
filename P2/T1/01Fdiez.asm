;  Programa que lee 2 números hexadecimales de 10 digitos, y los suma considerando acarreo

.MODEL SMALL

extrn lee2:near                     ; Func que lee un núm hex de 2 digitos
extrn des2:near                     ; Func que muestra dos digitos en pantalla
extrn reto:near                     ; Func que muestra un retorno de carro

.STACK

.DATA
numero1 db 5 dup(?)                 ; arreglo para el núm 1 (2 digitos por espa)
numero2 db 5 dup(?)                 ; arreglo para el núm 2 (2 digitos por espa)

.CODE
main:   mov ax, @data
        mov ds, ax

        mov bx, offset numero1      ; obtiene dir. del arreglo para 1er núm
        mov si, 0h                  ; inicializa índice en 0
        mov cx, 5h                  ; inicializa contador en 5
 lec_1: call lee2                   ; lee dos digitos
        mov [bx+si], al             ; los guarda en el indice actual
        inc si                      ; avanza al sig índice
        loop lec_1                  ; lee 2 digitos por ciclo hasta los 10

        call reto                   ; retorno de carro

        mov bx, offset numero2      ; obtiene dir. del arreglo para 2do núm
        mov si, 0h                  ; inicializa índice en 0
        mov cx, 5h                  ; inicializa contador en 5
 lec_2: call lee2                   ; lee dos digitos
        mov [bx+si], al             ; los guarda en el indice actual
        inc si                      ; avanza al sig índice
        loop lec_2                  ; lee 2 digitos por ciclo hasta los 10

        call reto                   ; retorno de carro

        clc                         ; instr. que limpia la band. de acarreo
        mov si, 4h                  ; inicializa índice en 4
        mov cx, 5h                  ; inicializa contador en 5
 suma2: mov ax, 0h                  ; inicializa 'ax' en 0
        mov al, [bx+si]             ; del 2do núm, guarda los 2 digitos actuales
        mov bx, offset numero1      ; obtiene dir. del arreglo del 1er núm
        mov dl, [bx+si]             ; del 1er núm, guarda los 2 digitos actuales
        adc al, dl                  ; suma los 2 digitos obtenidos
        push ax                     ; guarda el resultado en la pila
        dec si                      ; decrementa el índice
        mov bx, offset numero2      ; obtiene dir. del arreglo del 1er núm
        loop suma2                  ; repite hasta sumar todos los elementos

        mov cx, 5h                  ; a contador se le asigna 5
 mst2:  pop dx                      ; obtiene 2 digitos de la pila
        call des2                   ; los muestra en pantalla
        loop mst2                   ; repite hasta mostrar todos los digitos

       .exit 0

end
