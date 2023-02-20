; Para uso de la formula general (chicharronera)

.model small

.386
extrn fleeflo:near		; fun que lee un núm de punto flotante
extrn fdespflo:near		; fun que muestra un núm de de punto flotante
extrn reto:near			; retorno de carro

.stack

.data
; variables de números (flotantes de 32 bits)
a	dd	?
b	dd	?
c	dd	?
cuatro	dd	4
dos		dd	2
raiz	dd	?
; variable de resultado
result1	dd	?
result2	dd	?

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit

		print "Dato A: "
		call fleeflo
		call reto
		fstp a

		print "Dato B: "
		call fleeflo
		call reto
		fstp b

		print "Dato C: "
		call fleeflo
		call reto
		fstp c

		; sqrt(b^2 -4ac)
		fld b
		fmul st, st(0)
		fild cuatro
		fld a
		fmul
		fld c
		fmul
		fsub
		fsqrt
		fst raiz

		; -b + sqrt(b^2 -4ac)
		fld b
		fchs
		fadd
		fild dos
		fld a
		fmul
		fdiv
		fst result1

		; -b - sqrt(b^2 -4ac)
		fld b
		fchs
		fld raiz
		fsub
		fild dos
		fld a
		fmul
		fdiv
		fst result2

		; muestra resultados en pantalla
		fwait
		print "Resultado 1: "
		lea dx, result1
		call fdespflo
		call reto
		print "Resultado 2: "
		lea dx, result2
		call fdespflo

		.exit 0
end