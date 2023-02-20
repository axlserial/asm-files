; Programa que realiza una copia de los datos de un arreglo a otro
; Instrucción MOVSB (para Bytes)

.MODEL small

extrn des2:near
extrn espa:near
extrn reto:near

.STACK

.DATA
origen  db "abcdefg$"   ; arreglo original
destino db 8 dup(?)     ; arreglo destino de la copia  

.CODE

;---------------------

; Macro que automatiza imprimir un arreglo
; Recibe: direcc (dirección del arreglo)
;         tam    (tamaño del arreglo)
mDesArr macro direcc, tam
        mov dx, offset direcc
        mov cx, tam
        call desArr
        endm

;---------------------

main:   mov ax, @data
        mov ds, ax
        mov es, ax

        cld                         ; establece autoincremento
        mov si, offset origen       ; arreglo a leer (del cuál se copian los datos)
        mov di, offset destino      ; arreglo a escribir (guardar los datos)
        mov cx, 08                  ; tamaño del arreglo
        
        ; realiza la copia de lo que apunta 'si' a 'di' (repite el proceso lo indicado en 'cx')
        rep movsb

        mDesArr destino 08          ; muestra el arreglo copia
        call reto

        .exit 0

;---------------------
; Función que recibe un arreglo de
; números y lo muestra en pantalla
; Entrada: dx (dirección del arr)
;          cx (tamaño del arr)
desArr: push ax                     ; respalda 'ax'
        push si                     ; respalda 'si'
        mov si, dx                  ; apuntador a arreglo (para leer)
        cld                         ; indica autoincremento (despues de 'lodsb')
 da_c:  lodsb                       ; al = [si] // si++
        mov dl, al                  ; copia el dato a 'dl'
        call des2                   ; muestra el núm
        call espa                   ; espacio
        loop da_c                   ; repite el proceso
        pop si                      ; recupera 'si'
        pop ax                      ; recupera 'ax'
        ret

;---------------------
end