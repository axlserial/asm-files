; Programa que realiza la suma de leibniz hasta un valor n

.model small

.386
extrn leedec:near		; fun que lee un núm decimal
extrn fdespflo:near		; fun que muestra un núm de de punto flotante
extrn reto:near			; retorno de carro

.stack

.data
divisor	dd	3
result	dd	?
ndos	dd	2
cuatro	dd	4

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit

		print "Leibniz iteraciones: "
		call leedec
		call reto
		;mov ax, 0FFFFh
		mov cx, ax
		fld1
 cic:	fld1			; inicia acumulador en 1
		fild divisor
		fdiv			; 1 / divisor
		fsub			; 1 - (1 / divisor)
		fld1
		fild ndos
		fild divisor
		fadd			; 2 + divisor
		fist divisor
		fdiv			; 1 / (2 + divisor)
		fadd			; (1 - (1 / divisor)) + (1 / (2 + divisor))
		fild ndos
		fild divisor
		fadd			; 2 + divisor
		fistp divisor
		loop cic
		fild cuatro
		fmul

		fstp result
		fwait
		lea dx, result
		call fdespflo

		.exit 0
end