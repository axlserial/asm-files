; Programa que despliega una cadena de forma inversa (recursivamente)

.MODEL SMALL
.STACK

.DATA
cadena db "Ejercicio numero 2", 24h     ; cadena a invertir

.CODE
main:   mov ax, @data
        mov ds, ax

        mov ax, offset cadena       ; dirección de la cadena a 'ax'
        push ax                     ; se guarda como parámetro
        call inver                  ; func que invierte la cadena
        add sp, 02                  ; libera espacio de parámetro

        .exit 0

;---------------------

inver:  push bp                     ; se guarda el valor de 'bp'
        mov bp, sp                  ; se copia en 'bp' a lo que apunta 'sp'

        ; condición de salida
        mov bx, [bp+4]              ; copia el parámetro en 'bx'
        cmp byte ptr[bx], 24h       ; cmp con el signo '$'
        je in_s                     ;     sí es fin de cadena, salta
        
        ; recursividad
        inc bx                      ; avanza al sig carácter
        push bx                     ; se guarda como parámetro
        call inver                  ; llamada recursiva
        add sp, 02                  ; libera espacio de parámetro
        mov ah, 02h                 ; servicio para imprimir carácter
        mov bx, [bp+4]              ; dirección del carácter
        mov dl, [bx]                ; guarda en 'dl' el carácter
        int 21h                     ; lo muestra en pantalla

 in_s:  mov sp, bp                  ; se regresa el valor original de 'sp'
        pop bp                      ; 'bp' recupera su valor original
        ret

;---------------------
end