.model small

.386
extrn lee1:near
extrn fdespflo:near
extrn reto:near

.stack

.data
num	dd	?
res	dd	?

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit

		mov eax, 0
		; lee el número
		print "Numero: "
		call lee1
		call reto

		; llama a función
		push eax
		call fact
		add sp, 04

		; guarda resultado en variable
		fst res
		fwait

		; imprime resultado
		lea dx, res
		call fdespflo

		.exit 0

;-------------------

fact:	push bp                 ; se guarda el valor de 'bp'
		mov bp, sp              ; se copia en 'bp' a lo que apunta 'sp'
        
		; condición de salida
		mov eax, [bp+4]			; copia el parámetro en 'eax'
		cmp eax, 0				; cmp el parámetro (número) con un 0
		jg fc_u					;       sí el núm es mayor, salta a 'fc_u'
		fld1
		;mov ax, 01				; copia un 1 en 'ax'
		jmp fc_s				; salta a 'fc_s'
 fc_u:	cmp eax, 1				; cmp con un 1
		jne fc_c				;       sí el núm es igual, salta a 'fc_s'
		fld1
		jmp fc_s

 fc_c:	; recursividad
		dec eax					; decrementa en 1 el valor del número
		push eax				; parámetro para la llamada recursiva
		call fact				; llamada recursiva a 'fact'
		add sp, 04				; se libera el espacio del parámetro
		mov ebx, [bp+4]			; valor del parámetro de la llamada actual
		mov num, ebx
		fild num
		fmul					; res de la llamada recursiva * parámetro

		; el resultado ya está en la parte alta de la pila del coprocesador

 fc_s:	mov sp, bp              ; se regresa el valor original de 'sp'
		pop bp                  ; 'bp' recupera su valor original
		ret

;---------------------

end