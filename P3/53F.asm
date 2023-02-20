.model small

.286
extrn des2:near
extrn des4:near
extrn dbin8:near
extrn reto:near

.stack

.data
valor	dd	100.25

.code
include ..\fun\macros.asm

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		mov bx, offset valor
		add bx, 03
		mov cx, 4
 ciclo:	mov dl, [bx]
		call dbin8
		;call spc
		dec bx
		loop ciclo
		call reto

		print "Signo: "
		mov bx, offset valor
		add bx, 02
		mov ax, [bx]
		push ax
		mov dx, ax
		and dx, 1000000000000000b
		rol dx, 1
		add dl, 30h
		mov ah, 02h
		int 21h
		call reto

		print "Exponente: "
		pop ax
		shl ax, 1
		mov dl, ah
		call dbin8
		.exit 0
end