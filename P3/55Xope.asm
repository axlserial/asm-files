; Programa que realiza la operación ( A + (B / C) ) / ( D * (E / F) ) leyendo los números
; desde teclado utilizando el coprocesador matemático

.model small

.386
extrn fleeflo:near		; fun que lee un núm de punto flotante
extrn fdespflo:near		; fun que muestra un núm de de punto flotante
extrn reto:near			; retorno de carro

.stack

.data
result	dd	?	; variable donde se guardará el resultado final

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit	; inicia coprocesador

		; Lee A
		print "Dato A: "
		call fleeflo
		call reto
		; Lee B
		print "Dato B: "
		call fleeflo
		call reto
		; Lee C
		print "Dato C: "
		call fleeflo
		call reto

		fdiv	; B / C
		fadd	; A + (B / C)

		; Lee D
		print "Dato D: "
		call fleeflo
		call reto
		; Lee E
		print "Dato E: "
		call fleeflo
		call reto
		; Lee F
		print "Dato F: "
		call fleeflo
		call reto

		fdiv	; E / F
		fmul	; D * (E / F)
		fdiv	; ( A + (B / C) ) / ( D * (E / F) )
		fstp result		; guarda resultado de arriba en 'result'

		fwait
		print "Resultado: "
		lea dx, result
		call fdespflo	; muestra el resultado en pantalla

		.exit 0
end