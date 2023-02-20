; Programa que lee letras y las convierte en su opuesto (Mayuscula -> Minuscula o viceversa) hasta que lee un enter (0Dh)

.MODEL SMALL
.STACK 
.DATA

.CODE
main:   mov ax, @data           ; Obtiene la dirección de DATA (segmento de datos)
        mov ds, ax              ; y se guarda en 'ds'
 ini:   mov ah, 01h             ; servicio para leer un caracter
        int 21h                 ; lee letra de teclado
        mov bl, al              ; se guarda en 'bl'
        cmp bl, 0Dh             ; compara el valor ASCII introducido con el valor del enter
        je salir                ;   si se introdujo un enter, salta a 'salir' y se termina el programa
        cmp bl, 5Ah             ; compara si la letra es mayuscula o minuscula
        jle mayor               ;   si es mayuscula, salta a 'mayor' / si no, es minuscula
        sub bl, 20h             ; se le resta 20h al valor ASCII para convertirla en mayuscula
        jmp une                 ; salta al punto de unión, 'une'
 mayor: add bl, 20h             ; se le suma 20h al valor ASCII para convertirla en minuscula
 une:   mov ah, 02h             ; servicio para mostrar un caracter
        mov dl, bl              ; se mueve de 'bl' a 'dl' la letra transformada
        int 21h                 ; se muestra la letra en pantalla
        jmp ini                 ; regresa al inicio dado que el valor introducido no fué un enter 
 salir: .exit 0                 ; si se recibe un enter, sale del programa
end main