.MODEL SMALL

.286
public lee1
public lee2
public lee4
public leeDec
public des1
public des2
public des4
public desDec
public dbin8
public dbi16
public espa
public reto

.STACK
.DATA

.CODE

; Función que despliega en pantalla
; número hexadecimal de 16 bits 
; en base 10
; Entrada: dx
desDec: push ax                    ; respalda los datos de 'ax'
        push bx                    ; respalda los datos de 'bx'
        push cx                    ; respalda los datos de 'cx'
        push dx                    ; respalda los datos de 'dx'
        cmp dx, 0h                 ; cmp si el núm a mostrar es 0
        jne dd_s1                  ;      sí el núm no es 0 salta a 'dd_s1'
        mov ah, 02h                ; servicio para mostrar un char
        mov dl, '0'                ; el 0 a mostrar
        int 21h                    ; muestra el 0 en pantalla
        jmp dd_r                   ;      salta a 'dd_r' para terminar
 dd_s1: mov cx, 0h                 ; inicializa contador en 0
        mov ax, dx                 ; copia el núm en 'ax'
        mov bx, 0Ah                ; divisor para obt. el núm base 10
 dd_di: mov dx, 0h                 ; para ciclo, 'dx' inicia en 0
        div bx                     ; divide el núm para obtener el residuo
        push dx                    ; guarda ese residuo en la pila
        inc cx                     ; incrementa el contador
        cmp ax, 0h                 ; cmp el cociente con 0
        jne dd_di                  ;      sí no es 0, repite el proceso 
 dd_ms: pop dx                     ; recupera de la pila un digito del núm
        call des1                  ; muestra el digito (base 10)
        loop dd_ms                 ; repite hasta mostrar todos los digitos
 dd_r:  pop dx                     ; recupera valor original de 'dx'
        pop cx                     ; recupera valor original de 'cx'
        pop bx                     ; recupera valor original de 'bx'
        pop ax                     ; recupera valor original de 'ax'
        ret

;---------------------

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

;---------------------

; muestra núm de dos digitos
; en hexadecimal
; Entrada: dl
des2:  push bx                     ; respalda los datos de 'bx'
       mov bl, dl                  ; respalda el núm en 'bl'
       shr dl, 4                   ; recorre los bits 4 espacio a la der
       call des1                   ; llama a func que muestra el 1er dígito
       mov dl, bl                  ; recupera el núm y lo pone en 'dl'
       and dl, 00001111b           ; máscara para dejar solo los 4 bits de la der
       call des1                   ; llama a func que muestra el 2do dígito
       pop bx                      ; recupera los datos de 'bx' de la pila
       ret

;---------------------

; muestra núm en hexadecimal
; Entrada: dl
des1:  push ax                     ; respalda 'ax'
       add dl, 30h                 ; sumar 30h al núm
       cmp dl, 39h                 ; comp su valor
       jle d1s                     ;    si el núm es <= 9 salta a 'd1s'
       add dl, 07h                 ; es mayor (A-F), se le suman 7h
 d1s:  mov ah, 02h                 ; servicio para mostrar un char
       int 21h                     ; muestra el núm
       pop ax                      ; regresa 'ax' de la pila
       ret

;---------------------

; Función que lee un número base 10
; Hasta que se presione 'enter'
; MAX_VAL = 65535d
; Salida: ax
leeDec: push bx                    ; resguarda datos de 'bx'
        push cx                    ; resguarda datos de 'cx'
        push dx                    ; resguarda datos de 'dx'
        mov ax, 0h                 ; inicializa acumulador en 0
        mov bh, 0h                 ; inicializa 'bh' en 0
        mov cx, 0Ah                ; asigna a 'cx' el valor A
 ld_c:  push ax                    ; resguarda valor de acumulador
        call lee1                  ; lee un caracter (digito)
        cmp al, 0DDh               ; compara si es un enter
        je ld_s                    ; sale del ciclo si lo es
        mov bl, al                 ; resguarda el digito en 'bl'
        pop ax                     ; recupera valor de acumulador
        mul cx                     ; multiplica acumulador * 'cx' (0Ah)
        add ax, bx                 ; suma al resultado el digito leído
        jmp ld_c                   ; realiza el proceso hasta un 'enter'
 ld_s:  pop ax                     ; recupera valor final del acumulador
        pop dx                     ; recupera valor original de 'dx'
        pop cx                     ; recupera valor original de 'cx'
        pop bx                     ; recupera valor original de 'bx'
        ret

;---------------------

; Lee números de 4 dígitos
; hexadecimales
; Salida: ax        
lee4:  push bx                     ; respalda los datos de 'bx'
       call lee2                   ; lee los primeros 2 digitos
       mov bh, al                  ; guarda esos digitos en 'bh'
       call lee2                   ; lee los ultimos 2 digitos
       mov bl, al                  ; guarda esos digitos en 'bl'
       mov ax, bx                  ; guarda en 'ax' el núm completo
       pop bx                      ; recupera 'bx' respaldado
       ret

;---------------------

; func que lee y regresa un núm
; de dos digitos hexadecimal
; Salida: al
lee2:  push bx
       call lee1                   ; Obtiene el primer dígito
       shl al, 4                   ; lo mueve 4 bits a la izq
       mov bl, al                  ; lo guarda en 'bl'
       call lee1                   ; obtiene el segundo dígito
       or al, bl                   ; junta los dos dígitos
       pop bx
       ret                         ; regresa el núm final

;---------------------

; lee un número en hexadecimal
; Salida: al
lee1:  push bx                     ; respalda lo que tenga 'bx'
       mov bh, ah                  ; resguarda lo que contenga 'ah'
       mov ah, 01h                 ; servicio que lee un caracter
       int 21h                     ; lee el caracter
       sub al, 30h                 ; pasa de ASCII a valor núm
       cmp al, 09h                 ; comp el núm para saber si es núm o letra
       jle sig                     ;      si es núm salta a 'sig'
       sub al, 07h                 ; resta 07h 
       cmp al, 0Fh                 ; comp para saber si es una letra Mayús o Minús
       jle sig                     ;      si es Mayús salta a 'sig'
       sub al, 20h                 ; resta 20h si es Minús
 sig:  mov ah, bh                  ; regresa el valor original de 'ah'
       pop bx                      ; regresa el valor original de 'bx'
       ret

;---------------------

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

;---------------------

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

;---------------------

; Func que imprime un 'espacio'
espa:  push ax                     ; resguarda 'ax'
       push dx                     ; resguarda 'dx'
       mov ah, 02h                 ; servicio para imp caracter
       mov dl, 20h                 ; pone el ASCII del espacio
       int 21h                     ; muestra el espacio
       pop dx                      ; recupera 'dx'
       pop ax                      ; recupera 'ax'
       ret

;---------------------

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