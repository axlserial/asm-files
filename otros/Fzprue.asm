; Programa que muestra el codigo de la tecla introducida, hasta que se introduzca ESC

.model small

extrn des2:near
extrn espa:near
extrn reto:near

.stack
.data

.code
main:	mov ax, @data
		mov ds, ax
		mov es, ax	

 cic:	mov ah, 0
		int 16h

		; Sale si recibe la tecla ESC (01 1B)
		cmp ax, 011Bh
		je fin

		; BIOS KEYSTROKE
		mov dl, ah
		call des2
		call espa
		; ASCII VALUE
		mov dl, al
		call des2
		call reto
		jmp cic

 fin:	.exit 0
end