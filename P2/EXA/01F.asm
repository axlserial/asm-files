; Programa que tiene una función que reemplaza apartir de la letra indicada
; el contenido de un arreglo con una letra dada

.MODEL small

extrn des2:near   ; Func que muestra nums de 2 digitos hex 
extrn espa:near   ; Func que muestra espacio en pantalla
extrn reto:near   ; retorno de carro

.STACK

.DATA
cadena db "AAACCCAQOEMCX"       ; cadena sobre la que buscar
cadena_len = ($ - cadena)       ; tamaño de la cadena

.CODE

;--------------------
; Macro que muestra el contenido de un arreglo en pantalla
; Recibe la dirección del arr y su tamaño
mDisMem macro arr, tam
local ciclo
        push cx                 ; respalda 'cx'
        push bx                 ; respalda 'bx'
        push dx                 ; respalda 'dx'
        mov bx, offset arr      ; copia direcc en 'bx'
        mov cx, tam             ; copia tam en 'cx'
 ciclo: mov dl, [bx]            ; copia dato apuntado en 'dl'
        call des2               ; muestra el dato
        call espa               ; muestra un espacio
        inc bx                  ; avanza en el arreglo
        loop ciclo              ; repite hasta que cx == 0
        pop dx                  ; recupera 'dx'
        pop bx                  ; recupera 'dx'
        pop cx                  ; recupera 'dx'
endm
;--------------------

main:   mov ax, @data
        mov ds, ax
        mov es, ax

        ; Muestra cadena antes
        mDisMem cadena cadena_len
        call reto

        ; (bp == 10) Parámetro 1:
        mov ax, offset cadena
        push ax
        ; (bp == 8) Parámetro 2:
        mov ax, cadena_len
        push ax
        ; (bp == 6) Parámetro 3:
        mov ax, 'E'
        push ax
        ; (bp == 4) Parámetro 4:
        mov ax, 'Z'
        push ax

        ; Llamada a la función
        call rellena
        add sp, 08

        ; Muestra cadena después
        mDisMem cadena cadena_len

        .exit 0


; Función que busca una letra en una cadena
; y reemplaza con la letra indicada por
; la dada en el parámetro
rellena:
        ; Protocolo
        push bp
        mov bp, sp

        cld                     ; autoincremento
        mov ax, [bp+6]          ; letra buscar
        mov cx, [bp+8]          ; tam de la cadena
        mov di, offset [bp+10]  ; direcc de la cadena
        repne scasb             ; hasta encontrar la letra
        sub di, 01              ; regresa a la posición de la letra
        add cx, 01              ; y por lo tanto, agrega 1 a contador
        mov ax, [bp+4]          ; letra con la que se reemplazará
        rep stosb               ; realiza el reemplazo

        ; Protocolo
        mov sp, bp
        pop bp
        ret
end