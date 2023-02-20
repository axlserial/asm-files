
.MODEL small

extrn des2:near
extrn dbin8:near
extrn espa:near

.STACK

.DATA
valor	dd 	1.0

.CODE
main:	mov ax, @data
		mov ds, ax
		mov es, ax

		lea bx, valor
		add bx, 03
		mov cx, 4
 ciclo:	mov dl, [bx]
		call dbin8
		dec bx
		loop ciclo

		.exit 0
end