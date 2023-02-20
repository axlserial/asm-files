; Programa que muestra el resultado de la expresión:
; (1.17 * (4.1 + 5) * pi) / (sqrt(2.1 * 3.2) + 3)

.model small

.386
extrn fdespflo:near

.stack

.data
; Números a operar
A	dd	1.17
B	dd	4.1
C	dd	5
D	dd	2.1
E	dd	3.2
F	dd	3
resul	dd	?

.code
main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit
		fld A
		fld B
		fild C
		fadd		; B + C
		fmul		; A * (B + C)
		fldpi
		fmul		; A * (B + C) * PI
		fld D
		fld E
		fmul		; D * E
		fsqrt		; sqrt(D * E)
		fild F
		fadd		; sqrt(D * E) + 3
		fdiv			; (A * (B + C) * PI) / (sqrt(D * E) + 3)

		fstp resul	; guarda resultado final
		fwait
		lea dx, resul
		call fdespflo		; lo muestra en pantalla

		.exit 0
end