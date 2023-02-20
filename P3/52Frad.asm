.model small

.386
.387
extrn reto:near
extrn desdec:near
extrn des2:near
extrn des4:near

.stack

.data
RADIO		dd	2.0		; Flotante de 32 bits.
AREA		dd	?		; 32 bits, será flotante
MIL			dd	1000	; Entero 32 bits
AREAINT		dd	123		; Resultado entero por 1000
AREABCD		dt	?		; Resultado BCD 80 bits, 18 dígitos
BCD10K		dt	?
DIEZMIL		dd	10000	; Entero 31 bits

.code
main: 	mov ax, @data
		mov ds, ax
		mov es, ax
		finit			; inicializar coprocesador
		fld RADIO 		; Carga radio.
						;	Pila: 2.0
		fmul ST, ST(0)	; Multiplica tope de pila consigo mismo.
						;	Pila: 4.0
		fldpi			; Carga PI.
						;	Pila: 3.1416 4.0
		fmul			; Multiplica elementos superiores.
						;	Pila: 12.5664

		call desBcd10k
		
		fst AREA		; Guardar resultado en variable,
						;	sin extraer de la pila.
		fild MIL		; Cargar 1000.
						;	Pila: 1000.0 12.5664
		fmul			;	Pila: 12566.3706
		fist AREAINT	; Guardar resultado por 1000,
						;	como entero de 32 bits, extrayendo de la pila
						;	Pila: (vacía)
		fbstp AREABCD
		fwait 			; Esperar al coprocesador.
		lea bx, AREAINT
		mov dx, [bx]	; Cargar en DX (16 bits) parte baja
						; del resultado.
		call desdec		; Desplegar como entero base 10.
		call reto

		lea bx, AREABCD
		add bx, 08
		mov cx, 09
 cic1:	mov dl, [bx]
		call des2
		dec bx

		cmp cx, 3
		jne sal2
		mov ah, 02
		mov dl, '.'
		int 21h

 sal2:	loop cic1
		.exit 0


; Función para desplegar un número flotante de 4 decimales
; en el tope de la pila
desBcd10k:
		pusha
		; Hacer duplicado del número superior de la pila
		fld st(0)		; duplica
		fild DIEZMIL	; Meter a la pila el número 10000
		fmul			; Multiplicar
		fbstp BCD10K	; Guardar en variable de esta función
		fwait
		lea bx, BCD10K
		add bx, 08
		mov cx, 09
 dbd_1:	mov dl, [bx]
		call des2
		dec bx
		cmp cx, 03
		jne dbd_2
		mov ah, 02
		mov dl, '.'
		int 21h
 dbd_2:	loop dbd_1
		popa
		ret
end