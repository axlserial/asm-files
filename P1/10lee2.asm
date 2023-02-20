; Programa que lee un número hexadecimal de dos digitos (entre 0 y FF) y muestra 
; el mismo número en binario
; * HICE CAMBIOS EN EL RESGUARDO DE REGISTROS, PASE LOS PUSH Y POP DE AX A 'espa'

.MODEL SMALL
.STACK
.DATA

.CODE
main:  mov ax, @data               ; Obtiene la dirección de DATA (segm de datos)
       mov ds, ax                  ; y ponerlo en el registro DS
       call lee2                   ; llama a la función que lee un núm hex de dos digitos
       call espa                   ; llama a func que imprime un espacio
       mov dl, al                  ; pone el núm en 'dl'
       call dbin8                  ; llama a func que lo muestra en bin
       .exit 0   


; func que lee y regresa un núm
; de dos digitos hexadecimal
lee2:  call lee1                   ; Obtiene el primer dígito
       shl al, 4                   ; lo mueve 4 bits a la izq
       mov bl, al                  ; lo guarda en 'bl'
       call lee1                   ; obtiene el segundo dígito
       or al, bl                   ; junta los dos dígitos
       ret                         ; regresa el núm final

; lee un número en hexadecimal
lee1:  mov ah, 01h                 ; servicio que lee un caracter
       int 21h                     ; lee el caracter
       sub al, 30h                 ; pasa de ASCII a valor núm
       cmp al, 09h                 ; comp el núm para saber si es núm o letra
       jle sig                     ;      si es núm salta a 'sig'
       sub al, 07h                 ; resta 07h 
       cmp al, 0Fh                 ; comp para saber si es una letra Mayús o Minús
       jle sig                     ;      si es Mayús salta a 'sig'
       sub al, 20h                 ; resta 20h si es Minús
 sig:  ret

; Func que muestra el núm en bin
dbin8: mov bl, dl                  ; mueve el núm de 'dl' a 'bl'
       mov ah, 02h                 ; servicio para imp caracter
       mov cx, 08h                 ; pone un 8 en el contador
 db8c: mov al, bl                  ; pone el 'al' el núm
       and al, 10000000b           ; separa el bit de la izq
       jz db8e                     ;      si el res es cero salta a 'db8e'
       mov dl, '1'                 ; pone un '1' con res = uno
       jmp desp                    ; salta a 'desp'
 db8e: mov dl, '0'                 ; pone un '0' con res = cero
 desp: int 21h                     ; despliega el bit resultante
       shl bl, 1                   ; recorre 1 bit a la izq
       loop db8c                   ; hace el proceso hasta que cx == 0
       ret

; Func que imprime un 'espacio'
espa:  push ax                     ; resguarda 'ax'
       mov ah, 02h                 ; servicio para imp caracter
       mov dl, 20h                 ; pone el ASCII del espacio
       int 21h                     ; muestra el espacio
       pop ax                      ; recupera 'ax'
       ret

end