; Muestra el uso de la instruccion FCOMPP para comparar

.model small

.386
.387
extrn reto:near
extrn des2:near

.stack

.data
num1	dd	2.1
num2	dd	6.1

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit
		fld num1		; carga en pila 'num1'
		fld num2		; carga en pila 'num2'
		fcompp			; compara los núms y vacia la pila
		fstsw ax		; 'ax' tiene el resultado de la cmp
		fwait
		and ah, 45h		; Aplicar máscara a parte alta

		cmp ah, 00
		jne menor
		print "num1 < num2"
		jmp salir
 menor:	cmp ah, 01h
		jne igual
		print "num1 > num2"
		jmp salir
 igual:	print "num1 == num2"

 salir:	call reto
		print "Codigo: "
		mov dl, ah		; nos interesa solo parte alta
		call des2		; despliega resultado
		.exit 0
end

; Posibles resultados:
; 00: num1 < num2
; 01: num1 > num2
; 40: num1 == num2
; 45: valores no comparables