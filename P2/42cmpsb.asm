; Programa que demuestra el uso de la instrucción 'CMPSB' para comparar dos arreglos

.MODEL small
.286
.STACK

.DATA
arr1 db "minino"
arr2 db "minina"

.CODE

include ..\fun\macros.asm

main:   mov ax, @data
        mov ds, ax
        mov es, ax

        mov si, offset arr1
        mov di, offset arr2
        mov cx, 06

        ; se detendrá en dos posibles casos:
        ;   - encontró una diferencia
        ;   - 'cx' llegó a 0
        repe cmpsb              ; repe: rep = repite, e = mientras sean iguales

        ; son diferentes sí está apagada la band del cero
        jne difer

        print "Iguales"         ; acción por ser iguales
        jmp salid

 difer: print "Diferentes"      ; acción por ser diferentes
 salid: .exit 0

end