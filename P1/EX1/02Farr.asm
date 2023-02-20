; Programa que lee 5 números hex de 2 digitos, los guarda en un arreglo, suma esos valores
; y despliega el resultado en pantalla

.MODEL SMALL

.286
extrn lee2:near                     ; Función externa que lee un núm hex de 2 digitos
extrn des4:near                     ; Función externa que muestra un núm de 4 digitos
extrn espa:near                     ; Función que muestra un espacio en pantalla
extrn reto:near                     ; Función que muestra un retorno de carro

.STACK

.DATA
array db 5 dup(?)                   ; array de 5 elementos donde se guardarán los números

.CODE
main:   mov ax, @data               ; obtiene la dirección de DATA
        mov ds, ax                  ; la guarda en 'ds'

        mov bx, offset array        ; pone en 'bx' la dirección del arreglo
        mov si, 0h                  ; se pone al inicio del array (array[0])
        mov cx, 05h                 ; cantidad de números a leer
 lect:  call lee2                   ; lee el 1er núm de 2 digitos
        call espa                   ; muestra un espacio
        mov [bx+si], al             ; guarda el núm en la posición actual en el arreglo
        inc si                      ; avanza a la sig posición en el arreglo
        loop lect                   ; lee los 5 números

        call reto                   ; realiza un retorno de carro finalizada la lectura

        mov si, 0h                  ; regresa al inicio del arreglo
        mov cx, 05h                 ; cantidad de números a sumar
        mov dx, 0h                  ; inicializa 'dx' en 0
 suma:  mov al, [bx+si]             ; guarda el núm actual en 'al'
        and al, 00001111b           ; enmascaramiento para solo tener el digito de la der
        mov ah, [bx+si]             ; guarda el núm actual en 'ah'
        and ah, 11110000b           ; enmascaramiento para solo tener el digito de la izq
        add dl, al                  ; suma el digito de la der a 'dl'
        adc dh, 00h                 ; si en la suma anterior existió acarreo, lo suma a 'dh'
        add dl, ah                  ; suma el digito de la izq a 'dl'
        adc dh, 00h                 ; si en la suma anterior existió acarreo, lo suma a 'dh'
        inc si                      ; avanza al sig núm en el arreglo
        loop suma                   ; suma los 5 números

        call des4                   ; despliega el resultado de las sumas
        .exit 0

end