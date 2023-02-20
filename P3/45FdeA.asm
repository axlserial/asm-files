; Programa que muestra el uso de operaciones con archivos (abrir, leer, cerrar)

.MODEL small

.286
extrn des4:near
extrn desDec:near
extrn reto:near

.DATA
; Datos del archivo
nArchivo db "44fz.txt", 0h  ; nombre del archivo
handle   dw ?               ; file handle
; Buffer para almacenar datos
buffer   db 256 dup(?)      ; los caracteres son almacenados aquí

.CODE
include ..\fun\macros.asm

main:   mov ax, @data
        mov ds, ax
        mov es, ax

        ; Abrir para lectura
        mov ah, 3Dh
        mov al, 0
        mov dx, offset nArchivo
        int 21h
        jc error
        mov handle, ax

        ; Leer desde archivo
 leer:  mov ah, 3Fh
        mov bx, handle
        mov cx, 255                ; 0FFh bytes a leer
        mov dx, offset buffer
        int 21h
        jc error
        cmp ax, 0
        je cierr

        ; Colocar '$' al fin del buffer
        mov bx, ax
        add bx, offset buffer
        mov byte ptr [bx], '$'

        ; Despliega la cadena del buffer
        push ax
        print "Leidos: "
        mov dx, ax
        call desDec
        print " bytes"
        call reto
        mov dx, offset buffer
        mov ah, 09h
        int 21h
        pop ax
        cmp ax, 0ffh
        je leer

        ; Cerrar el archivo
 cierr: mov ah, 3Eh
        mov bx, handle
        int 21h
        jc error
        jmp fin

        ; En caso de algún error
 error: mov dx, ax      ; codigo de error
        print "Error: "
        call des4       ; lo despliega
        .exit 1         ; sale indicando que hubo error

 fin:   .exit 0
end