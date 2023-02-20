; Programa que lee y resta dos números hexadecimales y muestra el resultado en bin y hex
; utilizando funciones que se encuentran en otro archivo (fun.asm)

.MODEL SMALL
.286
extrn lee2:near
extrn des2:near
extrn espa:near
extrn dbin8:near
.STACK
.DATA

.CODE
main:  mov ax, @data               ; Obtiene la dirección de DATA (segm de datos)
       mov ds, ax                  ; y ponerlo en el registro DS
       call lee2                   ; llama a func que lee un núm hex de dos digitos
       call espa                   ; llama a func que imprime un espacio
       mov bl, al                  ; guarda el núm leído
       call lee2                   ; lee el segundo núm
       sub bl, al                  ; resta los dos núm y se guarda en 'bl'
       mov al, bl                  ; regresa el dato a 'al'
       call espa                   ; imprime espacio
       mov dl, al                  ; pone el núm en 'dl'
       call dbin8                  ; llama a func que lo muestra en bin
       call espa                   ; muestra un espacio
       mov dl, al                  ; pone el núm en 'dl'
       call des2                   ; llama a func que muestra el núm en hex
       .exit 0  
              
end