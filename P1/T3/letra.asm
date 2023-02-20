; programa que lee un número y una letra y la imprime del tamaño del número
.MODEL SMALL
.STACK
.DATA
.CODE
main:   mov ax, @data
        mov ds, ax

        mov ah, 01h         ; para leer un caracter
        
        int 21h             ; lee el número en ASCII
        mov bl, al          ; lo guarda en el registro 'bl'
        
        int 21h             ; lee el caractér 
        mov bh, al          ; lo guarda en el registro 'bh'
        
        sub bl, 30h         ; se le resta 30 hex para convertir de ASCII a número
        mov cl, bl          ; se guarda en 'cl' para uso como contador
        mov ch, 0h          ; para completar el registro 'cx'
        
        mov ah, 02h         ; para imprimir un caracter
        mov dl, 20h         ; pone en 'dl' el ASCII del espacio
        int 21h             ; muestra el espacio en pantalla
        mov dl, bh          ; pone en 'dl' el caracter leído
 ltra:  int 21h             ; muestra el caracter en pantalla
        loop ltra           ; Repite el proceso si el contador es != 0 
        
        .exit 0
end main
