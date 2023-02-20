.model small

.386

extrn fdespflo:near

.stack

.data
a	dd	1.234
b	dd	5.6
c	dd	8.1
d	dd	4.0
e	dd	8.5
f	dd	7.2

RESUL	dd	?

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax
		finit			;inicializar coprocesador

		fld a
		fld b
		fadd
		fld c
		fmul
		fld d
		fld e
		fld f
		fsub
		fadd
		fdiv

		fstp RESUL
		fwait
		print "Resultado: "
		lea dx, RESUL
		call fdespflo
		;call reto

	.exit 0
end