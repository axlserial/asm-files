; Programa que lee un número base 10 y lo muestra en pantalla en base 16 
; (1er algoritmo)

.MODEL SMALL

extrn lee1:near
extrn des4:near
extrn reto:near

.STACK
.DATA

.CODE
main:   mov ax, @data                   ; obtiene dirección de DATA
        mov ds, ax                      ; la guarda en 'ds'

        call leeDec                     ; lee el número en decimal
        call reto                       ; retorno de carro
        mov dx, ax                      ; guarda el núm en 'dx'
        call des4                       ; muestra el número en hexadecimal

        .exit 0


; Función que lee un número base 10
; Hasta que se presione 'enter'
; MAX_VAL = 65535d
; Salida: 'ax'
leeDec: push bx                         ; resguarda datos de 'bx'
        push cx                         ; resguarda datos de 'cx'
        push dx                         ; resguarda datos de 'dx'
        mov ax, 0h                      ; inicializa acumulador en 0
        mov bh, 0h                      ; inicializa 'bh' en 0
        mov cx, 0Ah                     ; asigna a 'cx' el valor A
 ld_c:  push ax                         ; resguarda valor de acumulador
        call lee1                       ; lee un caracter (digito)
        cmp al, 0DDh                    ; compara si es un enter
        je ld_s                         ; sale del ciclo si lo es
        mov bl, al                      ; resguarda el digito en 'bl'
        pop ax                          ; recupera valor de acumulador
        mul cx                          ; multiplica acumulador * 'cx' (0Ah)
        add ax, bx                      ; suma al resultado el digito leído
        jmp ld_c                        ; realiza el proceso hasta un 'enter'
 ld_s:  pop ax                          ; recupera valor final del acumulador
        pop dx                          ; recupera valor original de 'dx'
        pop cx                          ; recupera valor original de 'cx'
        pop bx                          ; recupera valor original de 'bx'
        ret

end