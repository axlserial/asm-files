; Programa que lee un archivo de texto y muestra el porcentaje de A's que contiene

.model small

.386
extrn des4:near
extrn desDec:near
extrn reto:near

.stack

.data
; Datos del archivo
nArchivo	db	"letras.txt", 0h	; nombre del archivo
handle		dw 	?					; file handle
; Buffer para almacenar datos
buffer		db	?					; alma. caracteres
; contadores
acont		dw	0
tcont		dw	0

.code
include ..\..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		; Abrir para lectura
		mov ah, 3Dh
		mov al, 0
		mov dx, offset nArchivo
		int 21h
		jc error
		mov handle, ax

		; Leer desde archivo
 leer:	mov ah, 3Fh
		mov bx, handle
		mov cx, 1			; se leerá 1 byte
		lea dx, buffer
		int 21h
		jc error
		cmp ax, 0
		je cierr				; sale sí terminó de leer

		; Verifica si el byte leído es
		; una 'A' u otro símbolo.
		; Aumenta contadores	
		cmp byte ptr [buffer], 'A'
		jne nchr			; sí lo leído != 'A', salta
		inc acont		; incrementa contador de A's
 nchr:	inc tcont		; incrementa contador total
		jmp leer			; realiza la sig lectura

		; Cerrar el archivo
 cierr:	mov ah, 3Eh
		mov bx, handle
		int 21h
		jc error

		; Muestra resultados
		mov ax, 100
		mul word ptr [acont]		; acont * 100
		div word ptr [tcont]		; acont * 100 / tcont
		print "El porcentaje de A's es: "
		mov dx, ax
		call desDec
		mov ah, 02h
		mov dl, '%'
		int 21h
		call reto
		print "Del total de caracteres: "
		mov dx, [tcont]
		call desDec

		; Termina el programa
 fin:	.exit 0

		; En caso de algún error
 error:	mov dx, ax		; codigo de error
		print "Error: "
		call des4		; lo despliega
		.exit 1			; sale indicando que hubo error

end