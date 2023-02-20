; Programa que lee todos los .txt y despliega su contenido si en los primeros 20 bytes 
; se encuentra a la palabra 'MIO'

.MODEL small

extrn reto:near

.STACK

.DATA
; Para atributos del archivo
patron  db  "*.txt", 0
DTA     db  21 dup(0)
attr    db  0
time    dw  0
date    dw  0
sizel   dw  0
sizeh   dw  0
fname   db  13 dup(0)
; Para almacenar datos
buffer  db 256 dup(?)
handle  dw ?

.CODE
main:   mov ax, @data
		mov ds, ax
		mov es, ax

		; Establece posición de DTA
		mov ah, 1Ah
		mov dx, offset DTA
		int 21h

		; Prepara lectura de directorio y muestra primer archivo
		mov dx, offset patron   ; patrón de búsqueda
		mov cx, 0               ; indica archivos normales
		mov ax, 4E00h           ; busca el primer archivo
		int 21h
		jc fin
		jmp abrir

		; Mostrar el resto de los archivos
 nf:    mov ah, 4Fh
		int 21h
		jc fin

		; Operaciones con archivo actual
		;       Abrir para lectura
 abrir: mov ah, 3Dh
		mov al, 0
		mov dx, offset fname
		int 21h
		mov handle, ax
		;       Leer desde archivo
		mov ah, 3Fh
		mov bx, handle
		mov cx, 255             ; 255 bytes a leer
		mov dx, offset buffer
		int 21h
		cmp ax, 0
		je cierr
		push ax
		;       Busqueda de la palabra 'MIO'
		mov cx, 20              ; busqueda 20 bytes 
		cld                     ; autoincremento
		mov di, offset buffer   ; buffer de datos
		mov al, 'M'             ; 1ra letra de la palabra
 busc:  repne scasb             ; busca la letra
		cmp cx, 0
		je cierr
		cmp byte ptr [di], 'I'
		jne busc
		cmp byte ptr [di+1], 'O'
		jne busc
		;       Muestra contenido sí se encontró
		push offset fname
		call despc				; muestra nombre de archivo
		add sp, 02
		call reto
		pop ax
		call muestra			; muestra contenido
		call reto
		call reto
		;       cerrar archivo
 cierr: mov ah, 3Eh
		mov bx, handle
		int 21h
		jmp nf

 fin:   .exit 0


;---------------------

; Función que despliega una cadena
; terminada en 0
; Entrada: parámetro por la pila
despc:  push bp
		mov bp, sp
		mov ah, 02h

		cld
		mov si, [bp+4]
 dcl:   lodsb
		cmp al, 0
		je dcs
		mov dl, al
		int 21h
		jmp dcl

 dcs:   mov sp, bp
		pop bp
		ret

;---------------------

; Fun que muestra el contenido de un archivo
muestra:
 ms_l:  push ax
		; Colocar '$' al fin del buffer
		mov bx, ax
		add bx, offset buffer
		mov byte ptr [bx], '$'
		; Despliega la cadena del buffer
		mov dx, offset buffer
		mov ah, 09h
		int 21h
		pop ax
		cmp ax, 0FFh
		jne ms_e
		; lee el resto del archivo
		mov ah, 3Fh
		mov bx, handle
		mov cx, 255
		mov dx, offset buffer
		int 21h
		cmp ax, 0
		jne ms_l
 ms_e:  ret

;---------------------
end