; Programa que demuestra el uso de la instrucción 'CMPSB' para buscar una palabra en un arreglo

.MODEL small
.286
.STACK

.DATA
arr1 db "Estaba don gato sentado en una silla de palo"  ; cadena donde se buscará
arr1_len = ($ - arr1)                                   ; tamaño de la cadena
arr2 db "gato"                                          ; palabra a buscar
arr2_len = ($ - arr2)                                   ; tamaño de la palabra

.CODE

include ..\fun\macros.asm

main:   mov ax, @data
        mov ds, ax
        mov es, ax
        
        ; Inicializar apuntadores
        ; (un registro apuntador de cadena, que no sea 'di')
        mov bx, offset arr1
        mov cx, arr1_len
        cld

        ; Repetir
        ;       Ajustar apuntadores y contador
 ciclo: push cx               ; resguarda 'cx' del ciclo que itera cadena
        mov si, offset arr2   ; copia en 'si' dirección de la palabra
        mov di, bx            ; copia en 'di' dirección de la cadena
        mov cx, arr2_len      ; tamaño de la palabra (y comparaciones con la cadena)
        ;       Realizar búsqueda en posición de apuntadores
        repe cmpsb   ; realiza la busqueda de la palabra apartir del índice
                     ; actual y 3 posiciones adelante, en la cadena 
        ;       (los apuntadores van a iterar los arreglos)
        je igual     ;     salta si son iguales (encontró la palabra)
        inc bx       ; avanza a la siguiente letra (índice) de la cadena
        pop cx       ; restaura el loop que itera la cadena
        loop ciclo   ;     sí no se encontró, se repite la iteración 'cx' veces

        ;       Sí se terminó la cadena donde se busca y no se encontró la palabra
        print "palabra no encontrada"  ; desplegar "no hay"
        jmp slida                      ; salir

 igual: ;       Sí coinciden palabras
        print "Palabra encontrada" ; desplegar resultado
                                   ; salir

 slida: .exit 0
end