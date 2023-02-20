; Programa que muestra el uso de variables globales para almacenar datos
; * Muestra la suma de 'datoa' y 'datob'

.MODEL SMALL
.STACK
.DATA
    datoa   db 5
    datob   db 3
    datores db ?
.CODE
main:
        mov ax, @data               ; Obtiene la dirección de DATA (segmento de datos)
        mov ds, ax                  ; y ponerlo en el registro DS

        ; Suma
        mov al, datoa               ; guarda en 'al' lo contenido en 'datoa'
        mov ah, datob               ; guarda en 'ah' lo contenido en 'datob'
        add al, datob               ; suma 'al' con 'datob'

        ; Pasos para convertir el número en su valor ASCII
        mov datores, al             ; copia en 'datores' el contenido de 'al'
        add datores, 30h            ; le suma 30h
        mov ah, 02h                 ; asigna un 2 a 'ah'
        mov dl, datores             ; valor ASCII a mostrar
        int 21h                     ; muestra el número

        .exit 0   
end
