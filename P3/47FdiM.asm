; Programa que lista muestra los archivos que cumplan un patrón

.MODEL small

extrn reto:near

.STACK

.DATA
patron  db  "*.*", 0
DTA     db  21 dup(0)
attr    db  0
time    dw  0
date    dw  0
sizel   dw  0
sizeh   dw  0
fname   db  13 dup(0)

.CODE

main:   mov ax, @data
        mov ds, ax
        mov es, ax

        ; Establece posición de DTA
        mov ah, 1Ah
        mov dx, offset DTA
        int 21h

        ; Prepara lectura de directorio y muestra primer archivo
        mov dx, offset patron   ; patrón de búsqueda
        mov cx, 0               ; indica archivos normales
        mov ah, 4Eh             ; busca el primer archivo
        int 21h
        jc sale
        ;       desplegar nombre
        push offset fname
        call despc
        add sp, 02
        call reto

        ; Mostrar el resto de los archivos
 nf:    mov ah, 4Fh
        int 21h
        jc sale
        push offset fname
        call despc
        add sp, 02
        call reto
        jmp nf

 sale:  .exit 0


;---------------------

; Función que despliega una cadena
; terminada en 0
; Entrada: parámetro por la pila
despc:  push bp
        mov bp, sp
        mov ah, 02h

        cld
        mov si, [bp+4]
 dcl:   lodsb
        cmp al, 0
        je dcs
        mov dl, al
        int 21h
        jmp dcl

 dcs:   mov sp, bp
        pop bp
        ret

;---------------------
end