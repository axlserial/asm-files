; macros para el pintar píxeles en pantalla

pixel	macro color, x, y
		push ax
		push cx
		push dx
		mov al, color
		mov ah, 0Ch
		mov cx, x
		mov dx, y
		int 10h
		pop dx
		pop cx
		pop ax
endm

pixelo	macro color, x, y
		push ax
		push cx
		push dx
		mov al, color
		mov ah, 0Ch
		mov cx, x
		add cx, offx
		mov dx, y
		add dx, offy
		int 10h
		pop dx
		pop cx
		pop ax
endm