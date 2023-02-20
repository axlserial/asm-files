; Programa que lee el archivo "negado.???" y muestra su contenido omitiendo
; todas las ocurrencias de "no"

.model small

.286
extrn des4:near

.stack

.data
; Para atributos del archivo
patron  db  "negado.*", 0
DTA     db  21 dup(0)
attr    db  0
time    dw  0
date    dw  0
sizel   dw  0
sizeh   dw  0
fname   db  10 dup(0)		; "negado" + "." + "???" = 10
; Buffer para almacenar datos
buffer   db 256 dup('$')	; los caracteres son almacenados aquí
handle   dw ?               ; file handle

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		; Establece posición de DTA
		mov ah, 1Ah
		lea dx, DTA
		int 21h

		; prepara lectura de archivo
		lea dx, patron
		mov cx, 0
		mov ax, 4E00h
		int 21h
		jc fin

		; Abrir para lectura
		mov ah, 3Dh
		mov al, 0
		lea dx, fname
		int 21h
		jc error
		mov handle, ax

		; Leer desde archivo
		mov ah, 3Fh
		mov bx, handle
		mov cx, 255				; 0FFh bytes a leer
		lea dx, buffer
		int 21h
		jc error

		mov cx, ax				; ciclo de la cant de chars leidos 
		cld
		lea di, buffer
		mov al, 'n'				; primera letra buscar
 busc:	repne scasb				; busca la letra
		cmp cx, 0
		je muest
		cmp byte ptr [di], 'o'
		jne busc
		dec di
		mov byte ptr [di], 20h	; pone un espacio
		inc di
		mov byte ptr [di], 20h
		jmp busc

 muest: lea dx, buffer			; despliega contenido
		mov ah, 09h
		int 21h
		
		; cierra el archivo
		mov ah, 3Eh
		mov bx, handle
		int 21h

 fin:	.exit 0

        ; En caso de algún error
 error:	mov dx, ax      ; codigo de error
		print "Error: "
		call des4       ; lo despliega
		.exit 1         ; sale indicando que hubo error
end