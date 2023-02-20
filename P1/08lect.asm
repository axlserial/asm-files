; Programa que muestra un número hexadecimal (entre 0 y 15<F>) en binario

.MODEL SMALL
.STACK

.DATA
dato db ?

.CODE
main:  mov ax, @data               ; Obtiene la dirección de DATA (segm de datos)
       mov ds, ax                  ; y ponerlo en el registro DS
       call lee1                   ; llama a la función que lee un núm hex
       mov dato, al                ;      resguarda el núm leído en 'dato'
       call espa                   ;      llama a func que imprime un espacio
       mov al, dato                ;      regresa el núm leído a 'dato'
       mov dl, al                  ; pone el núm en 'dl'
       call dbin8                  ; llama a func que lo muestra en bin
       .exit 0   

; lee numeros en hexadecimal
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
espa:  mov ah, 02h                 ; servicio para imp caracter
       mov dl, 20h                 ; pone el ASCII del espacio
       int 21h                     ; muestra el espacio
       ret

end