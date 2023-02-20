; Programa que lee un número hexadecimal de cuatro digitos y muestra 
; el resultado en bin y hex
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
       call lee4                   ; lee un núm de 4 digitos y lo guarda en 'ax'
       call espa                   ; muestra un espacio en pantalla
       mov dx, ax                  ; pone el núm en 'dx'
       call des4                   ; muestra el núm de 4 digitos en hex
       call espa                   ; muestra un espacio en pantalla
       mov dx, ax                  ; pone el núm en 'dx'
       call dbi16                  ; muestra el núm de 4 digitos en bin
       .exit 0


; Muestra un núm de 4 digitos
; en binario (16 bits)
; Entrada: dx 
dbi16: push bx                     ; respalda los datos de 'bx'
       mov bx, dx                  ; pone el núm en 'bx'
       mov dl, bh                  ; pone los 2 primeros digitos en 'dl'
       call dbin8                  ; despliega en bin esos digitos
       mov dl, bl                  ; pone los 2 ultimos digitos en 'dl'
       call dbin8                  ; despliega en bin esos digitos
       pop bx                      ; recupera 'bx' respaldado
       ret

; Muestra núm de 4 digitos
; en hexadecimal
; Entrada: dx
des4:  push bx                     ; respalda los datos de 'bx'
       mov bx, dx                  ; pone el núm en 'bx'
       mov dl, bh                  ; pone los 2 primeros digitos en 'dl'
       call des2                   ; despliega en hex esos digitos
       mov dl, bl                  ; pone los 2 ultimos digitos en 'dl'
       call des2                   ; despliega en hex esos digitos
       pop bx                      ; recupera 'bx' respaldado
       ret

; Lee números de 4 dígitos
; hexadecimales
; Salida: ax        
 lee4: push bx                     ; respalda los datos de 'bx'
       call lee2                   ; lee los primeros 2 digitos
       mov bh, al                  ; guarda esos digitos en 'bh'
       call lee2                   ; lee los ultimos 2 digitos
       mov bl, al                  ; guarda esos digitos en 'bl'
       mov ax, bx                  ; guarda en 'ax' el núm completo
       pop bx                      ; recupera 'bx' respaldado
       ret

end