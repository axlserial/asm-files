; Programa que realiza la busqueda de un simbolo en un arreglo
; Instrucción SCASB (Para Bytes)

.MODEL small
.286

.STACK

.DATA
arreglo db "BBBBAZDUBB"         ; arreglo donde se realizará la búsqueda

.CODE

include ..\fun\macros.asm       ; se hace uso del macro 'print'

main:   mov ax, @data
        mov ds, ax
        mov es, ax

        mov al, 'A'             ; copia en 'al' el símbolo a buscar
        mov cx, 10              ; tamaño del arreglo en el que se buscará
        cld                     ; indica autoincremento
        mov di, offset arreglo  ; copia en 'di' la dirección del arreglo

        repne scasb             ; recorre el arr y repite 'scasb' hasta que: cx == 0 || di == al
        jne noen                ; sí no se encontró el simbolo, salta a 'noen'
        mov al, 'Z'
        repne scasb             ; recorre el arr y repite 'scasb' hasta que: cx == 0 || di == al
        jne noen                ; sí no se encontró el simbolo, salta a 'noen'
        mov al, 'D'
        repne scasb             ; recorre el arr y repite 'scasb' hasta que: cx == 0 || di == al
        jne noen                ; sí no se encontró el simbolo, salta a 'noen'

        print "Encontrado "      ; sí fué encontrado
        mov ah, 02h
        mov dl, [di]
        int 21h
        jmp fin                 ; salta a 'fin'

 noen:  print "no encontrado"   ; sí no fué encontrado
 fin:   .exit 0

end