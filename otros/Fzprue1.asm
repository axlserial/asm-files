.model small

extrn des4:near
extrn reto:near

.stack
.data

.code
main:	mov ax, @data
		mov ds, ax
		mov es, ax

		mov cx, 0FFFFh
 cic:	loop cic

		mov dx, 4
		call des4

		.exit 0
end