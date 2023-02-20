; Programa que muestra el uso de operaciones con archivos (crear, escribir, cerrar)

.MODEL small

.286
extrn des4:near

.STACK

.DATA
nArchivo db     "44fz.txt", 0h          ; nombre del archivo
content  db     "Guardando en archivo"  ; contenido a guardar
cont_len = ($ - content)                ; tamaño del contenido
handle   dw     ?                       ; file handle

.CODE

include ..\fun\macros.asm

main:   mov ax, @data
        mov ds, ax
        mov es, ax

        ; Crear y abrir archivo
        mov ah, 3Ch             ; función que crea archivo
        mov cx, 0               ; un archivo normal
        mov dx, offset nArchivo ; nombre del archivo
        int 21h                 ; intenta crear y abrir el archivo
        jc error                ; sí hubo algún error, salta a 'error'
        mov handle, ax          ; guarda identificador del archivo en 'handle' 

        ; Escribir archivo
        mov ah, 40h             ; función que escribe en archivo
        mov bx, handle          ; identificador de archivo
        mov cx, cont_len        ; tamaño de los datos a guardar
        mov dx, offset content  ; dirección de los datos a guardar (buffer)
        int 21h                 ; intenta escribir archivo
        jc error                ; sí hubo algún error, salta a 'error'
        ;       despliega cuantos bytes se escribieron
        print "bytes escritos: "
        mov dx, ax
        call des4               ; despliega el valor
        print "h"

        ; Cerrar archivo
        mov ah, 3Eh     ; función para cerrar un archivo abierto
        mov bx, handle  ; archivo a cerrar
        int 21h         ; intenta cerrar el archivo
        jc error        ; sí hubo algún error, salta a 'error'
        jmp fin         ; termina el programa

        ; En caso de algún error
 error: mov dx, ax      ; codigo de error
        print "Error: "
        call des4       ; lo despliega
        .exit 1         ; sale indicando que hubo error

 fin:   .exit 0
end