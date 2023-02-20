; Para saber el tamaño de un arreglo definido en DATA

.MODEL small

extrn des2:near
extrn desDec:near
extrn espa:near

.STACK

.DATA
arr1 db "Estaba gan gato sentado en una silla de palo"
arr1_len = ($ - arr1)   ; posición actual ($) menos el inicio del arreglo
arr2 db "gato"

.CODE
main:   mov ax, @data
        mov ds, ax
        
        mov dx, arr1_len        ; guarda en tamaño en dx
        call desDec             ; lo muestra en pantalla
        
        call espa

        mov dx, arr1_len
        call des2

        .exit 0
end