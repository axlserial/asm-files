; Programa que lee un caracter y muestra su valor ASCII en binario,
; hace un desplazamiento de un bit hacia la izquierda con el bit más significativo
; tomando el lugar del menos significativo y muestra el resultado 

.MODEL SMALL
.STACK

.DATA
dato db ?

.CODE
main:  mov ax, @data               ; Obtiene la dirección de DATA (segmento de datos)
       mov ds, ax                  ; y ponerlo en el registro DS

       mov ah, 01h                 ; función para leer un caracter
       int 21h                     ; lo lee
       mov dato, al                ; copia lo leído en 'dato'
       call reto                   ; muestra retorno de carro
       mov dl, dato                ; copia el dato en 'dl'
       call dbin8                  ; muestra su ASCII en binario
       call reto                   ; muestra retorno de carro
       mov dl, dato                ; copia el dato en 'dl'
       rol dl, 1                   ; hace el desplazamiento
       call dbin8                  ; muestra el resultado

       .exit 0   

; Func que muestra el núm en bin
; Entrada: dl
dbin8: push ax                     ; respalda los datos de 'ax'
       push bx                     ; respalda los datos de 'bx'
       push cx                     ; respalda los datos de 'cx'
       mov bl, dl                  ; mueve el núm de 'dl' a 'bl'
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
       pop cx                      ; recupera 'cx' respaldado
       pop bx                      ; recupera 'bx' respaldado
       pop ax                      ; recupera 'ax' respaldado
       ret
       
; Func que hace un salto a nueva linea
reto:  push ax                     ; resguarda 'ax'
       push dx                     ; resguarda 'dx'
       mov ah, 02h                 ; servicio para imp caracter
       mov dl, 0Dh                 ; ASCII del regreso al ini de linea
       int 21h                     ; regresa al inicio de la linea
       mov dl, 0Ah                 ; ASCII del salto de linea
       int 21h                     ; hace el salto de linea
       pop dx                      ; recupera 'dx'
       pop ax                      ; recupera 'ax'
       ret

end