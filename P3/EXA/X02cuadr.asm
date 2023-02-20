; Programa que realiza la siguiente operación:
; ( ( (3.2*pi) + 3.2 )/( pi + 1 ) )²

.model small

.386
extrn fdespflo:near

.stack

.data
; Números a operar
A		dd	3.2
resul	dd	?

.code
main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit

		fld A
		fldpi
		fmul				; 3.2 * PI
		fld A
		fadd				; (3.2 * PI) + 3.2
		fldpi
		fld1
		fadd				; PI + 1
		fdiv					; ((3.2 * PI) + 3.2) / (PI + 1)
		fmul st, st(0)		; (((3.2 * PI) + 3.2) / (PI + 1))²

		fstp resul			; guarda resultado
		fwait
		lea dx, resul
		call fdespflo			; lo muestra en pantalla

		.exit 0
end