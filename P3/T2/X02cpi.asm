; Programa que muestra el resultado de la expresión con datos proporcionados por el usuario:
; A + ( sqrt( ( B + (A * C) ) ) / ( A * pi ) )

.model small

.386
extrn reto:near
extrn fleeflo:near
extrn fdespflo:near

.stack

.data
; Números a operar
A	dd	?
B	dd	?
C	dd	?
resul	dd	?

.code
include ..\..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		finit

		; Lee número A
		print "Introduce A: "
		call fleeflo
		call reto
		fstp A
		
		; Lee número B
		print "Introduce B: "
		call fleeflo
		call reto
		fstp B

		; Lee número C
		print "Introduce C: "
		call fleeflo
		call reto
		fstp C

		fld A
		fld C
		fmul		; A * C
		fld B
		fadd		; B + (A * C)
		fsqrt		; sqrt(B + (A * C))
		fld A
		fldpi
		fmul		; A * PI
		fdiv		; (sqrt(B + (A * C))) / (A * PI)
		fld A
		fadd		; A + ((sqrt(B + (A * C))) / (A * PI))

		fstp resul	; guarda el resultado en la variable
		fwait
		lea dx, resul
		call fdespflo	; muestra resultado en pantalla

		.exit 0
end