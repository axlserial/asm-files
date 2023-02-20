; Programa que tiene una función que muestra contenido de un arreglo

.MODEL small

extrn des2:near
extrn espa:near
extrn reto:near

.STACK

.DATA
arreglo db 20 dup(?)      ; arreglo sobre el que se iterará

.CODE
main:   mov ax, @data
        mov ds, ax                  ; segmento de datos
        mov es, ax                  ; segmento extra

        ; guardado de datos en arreglo
        mov cx, 20                  ; repeticiones
        mov di, offset arreglo      ; apuntador a arreglo (para escribir)
        cld                         ; indica autoincremento
        mov al, 0Fh                 ; dato a ingresar al arreglo n veces
        rep stosb                   ; sustituye a 'loop':
                                    ;   repite la instrucción la cantidad en 'cx'
        
        mov dx, offset arreglo      ; copia direc de 'arreglo' en 'dx'
        mov cx, 20                  ; tam de 'arreglo'
        call desArr                 ; lo muestra en pantalla


        .exit 0

;---------------------
; Función que recibe un arreglo
; y lo muestra en pantalla
; Entrada: dx (dirección del arr)
;          cx (tamaño del arr)
desArr: mov si, dx                  ; apuntador a arreglo (para leer)
        cld                         ; indica autoincremento (despues de 'lodsb')
 da_c:  lodsb                       ; al = [si] // si++
        mov dl, al
        call des2                   ; muestra el núm
        call espa                   ; espacio
        loop da_c                   ; repite el proceso
        call reto
        ret

;---------------------
end