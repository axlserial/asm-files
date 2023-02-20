; Programa que muestra un punto amarillo en pantalla

.MODEL small
.STACK
.CODE
main:   ;
        mov ax, 4F03h ;ah, 0Fh
        int 10h
        push bx ;ax

        ; definir pantalla 1024x768, 256 colores
        ;mov ah, 0
        ;mov al, 12h
        mov ax, 4F02h
        mov bx, 105h
        int 10h

        ; desplegar pixel
        mov al, 0Eh         ; amarillo
        mov ah, 0Ch         ; func escribir punto
        mov cx, 0200
        mov dx, 0280
        int 10h

        ; esperar al usuario
        mov ah, 0
        int 16h

        ; restaurar pantalla
        pop bx ;ax
        ;mov bx, 10h
        mov ax, 4F02h;ah, 0
        int 10h

        .exit 0
end
