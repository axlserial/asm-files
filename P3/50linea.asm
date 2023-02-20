.model small
.386
.stack
.data
gmodo	dw	?
offx	dw	0
offy	dw	0
incx	dw	2
incy	dw 	2

.code

pixel	macro	color, x, y
		al,color
		mov ah,0Ch
		mov cx,x
		mov dx,y
		int 10h
endm

pixelo	macro	color, x, y
		mov al,color
		mov ah,0Ch
		mov cx,x
		add cx,offx
		mov dx,y
		add dx,offy
		int 10h
endm

main:	mov ax,@data
		mov ds,ax
		mov es,ax

		call iniGraf	;Inicializar, usa pila

		mov offx,200
		mov offy,200

		mov cx,0FFFFh
	
 ciclo:	call linea
 		mov ax, incx
 		add offx, ax
		mov ax, incy
 		add offy, ax
 		call retraso
 		call borra
	
 		;Ver si hay algún teclazo
 		mov ah,06
 		mov dl,0FFh	;para leer del teclado sin bloqueo
 		int 21h
 		;jz sig1
 		cmp al,'a'
 		jne sig1
 		mov incx, -2
 		jmp sigx
 sig1:	cmp al, 'd'
 		jne sig2
 		mov incx, 2
 		jmp sigx
		
 sig2:	cmp al, 'w'
		jne sig3
		mov incy, -2
		jmp sigx
 sig3:	cmp al, 's'
		jne sig4
		mov incy, 2
		jmp sigx


 sig4:	cmp al, 'q'
 		je sale

		; verificar posiciones
		cmp offx, 50
		jg sig5
		mov incx, 2
		jmp sig6
 sig5:	cmp offx, 300
		jl sig6
		mov incx, -2
 sig6:

 sigx:

 		jmp ciclo


	
		;esperar usuario
		mov ah,00h
		int 16h
	
 sale:	call finGraf
 fin:	.exit 0

;Dibuja una línea desde el origen hacia la derecha 100 px
; considerando el offset (transformación de tranlación)
linea:	push bx
		push cx

		mov cx,100
		mov bx,0
 lcic:	push cx
 		pixelo 0Eh bx 0	;pixelo considera el offset
 		pop cx
 		inc bx
 		loop lcic
	
 		pop cx
 		pop bx
 		ret
;------
;Producir un retraso en pantalla
retraso:
		push cx
		mov cx,0FFFFh
 rciclo:
		push cx
		mov cx,01h
 rcic2:	loop rcic2	
		pop cx
		loop rciclo
		pop cx
		ret

borra:	push ax
		push bx
		;definir pantalla 1024x768, 256 colores
		; ya lo tenía, pero al redefinir, se borra
		mov ax,4f02h
		mov bx,105h 	;Código del modo.
		int 10h

		pop bx
		pop ax

		ret

;Obtener configuración de pantalla y guardarla en la pila
iniGraf:
		mov ax,4f03h
		int 10h
		mov gmodo,bx

		;definir pantalla 1024x768, 256 colores.
		mov ax,4f02h
		mov bx,105h 	;Código del modo.
		int 10h
		ret
	
;Restaurar pantalla
finGraf:
		mov bx,gmodo
		;mov bx,10Ch
		mov ax,4f02h
		int 10h
		ret
end