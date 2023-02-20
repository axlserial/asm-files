; Demuestra uso de la instrucción XTRACT (POR TERMINAR)

.model small

.386
extrn fleeflo:near		; fun que lee un núm de punto flotante
extrn fdespflo:near		; fun que muestra un núm de de punto flotante
extrn fdstackf:near
extrn reto:near			; retorno de carro

.stack

.data
; variables de números (flotantes de 32 bits)
a	dd	1.23


.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit

		;print "Dato A: "
		;call fleeflo
		;call reto
		;fstp a
		call fdstackf
		fld a
		fxtract


		call fdstackf
		fwait
		;print "Resultado 1: "
		;lea dx, result1
		;call fdespflo
		;call reto
		.exit 0
end