; Programa que despliega número hexadecimal de 16 bits en pantalla en base 10

.MODEL SMALL

extrn lee4:near
extrn des1:near
extrn reto:near

.STACK
.DATA

.CODE
main:   mov ax, @data              ; obtiene dirección de DATA
        mov ds, ax                 ; la guarda en 'ds'

        call lee4                  ; lee un núm hex de 4 digitos
        call reto                  ; retorno de carro
        mov dx, ax                 ; copia el núm a 'dx'
        call desDec                ; muestra el núm en base 10

        .exit 0

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

end