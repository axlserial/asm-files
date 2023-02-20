; Sumatoria usando el coprocesador

.model small

.386
extrn leedec:near
extrn fdespflo:near		; fun que muestra un núm de de punto flotante
extrn reto:near			; retorno de carro

.stack

.data
; variable de número
conta	dd	1
resul	dd	?

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit

		print "(int) Sumatoria: "
		call leedec
		call reto
		fldz		; inicializa acumulador
		mov cx, ax
		fild conta

 cic:	fadd
		fild conta
		fld1
		fadd
		fist conta
		loop cic

		fstp resul
		fstp resul

		fwait
		lea dx, resul
		call fdespflo

		.exit 0
end