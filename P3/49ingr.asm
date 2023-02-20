; Programa que muestra el uso de la función 'iniGraf' para establecer el modo gráfico
; Muestra figuras de color cian en pantalla (rectangulo vacio y relleno, rombo)

.MODEL small
.STACK
.DATA
gmode   dw ?	; modo de video
offx    dw 0	; offset en x
offy    dw 0	; offset en y
diag	dw 0	; utilizada para crear la diagonal

.CODE

; Macro que dibuja un pixel
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

main:	mov ax, @data
		mov ds, ax
		mov es, ax

		; inicia el modo SVGA
		call iniGraf

		; dibuja un rectangulo de 300x200 (x, y) vacio
		mov offx, 100	; pos inicio en x
		mov offy, 100	; pos inicio en y
		call lineaH		; dibuja linea H. apartir de coordenas
		call lineaV		; dibuja linea V. apartir de coordenas
		mov offy, 300	; posición en x
		call lineaH		; dibuja linea H.
		mov offx, 399	; pos inicio en x
		mov offy, 100	; pos inicio en y
		call lineaV		; dibuja linea V. faltante

		; dibuja un rectangulo de 300x200 (x, y) relleno
		mov bx, 400		; posición inicio para y
		mov offx, 100	; establece inicio x
 rec_r:	mov offy, bx		; establece y
		call lineaH		; dibuja una linea recta
		inc bx			; avanza 1 en y
		cmp bx, 601		; cmp para saber si se llegó al y límite
		jne rec_r		; repite hasta que se cumpla

		; dibuja un rombo con todos su lados de 200 píxeles
		;	posiciones para parte de arriba
		mov offx, 600		; inicio para x
		mov offy, 200		; inicio para y
		call DiagonalIzq		; dibuja diagonal izquierda
		call DiagonalDer		; dibuja diagonal derecha
		;	posiciones para parte de abajo
		mov offx, 450		; inicio para x (der)
		mov offy, 350		; inicio para y (der y izq)
		call DiagonalDer		; dibuja diagonal derecha
		mov offx, 749		; inicio para x (izq)
		call DiagonalIzq		; dibuja diagonal izquierda
		
		; esperar al usuario
		mov ah, 0
		int 16h

		; regresa al modo de video original
		call finGraf

		.exit 0


;---------------------

; Dibuja una linea desde el origen
; hacia la derecha 300 px
; considerando el offset
lineaH:	push bx
		push cx
		mov cx, 300		; tamaño de la línea
		mov bx, 0
 ci_lh:	pixelo 03h bx 0
		inc bx
		loop ci_lh		; el ciclo dibuja la línea
		pop cx
		pop bx
		ret

;---------------------

; Dibuja una linea desde el origen
; hacia abajo 200 px
; considerando el offset
lineaV:	push bx
		push cx
		mov cx, 200		; tamaño de la línea
		mov bx, 0
 ci_lv:	pixelo 03h 0 bx
		inc bx
		loop ci_lv		; el ciclo dibuja la línea
		pop cx
		pop bx
		ret

;---------------------

; Dibuja una diagonal desde el origen
; hacia la izquierda 150 px
; considerando el offset
DiagonalIzq:
		push bx
		push cx
		mov cx, 150
		mov bx, 0
		mov diag, 150	; tamaño de la diagonal
 di_cz:	pixelo 03h diag bx
		inc bx
		dec diag
		loop di_cz		; el ciclo dibuja la diagonal
		pop cx
		pop bx
		ret

;---------------------

; Dibuja una diagonal desde el origen
; hacia la derecha 150 px
; considerando el offset
DiagonalDer:
		push bx
		push cx
		mov cx, 150
		mov bx, 0
		mov diag, 150	; tamaño de la diagonal
 di_cd:	pixelo 03h diag bx
		inc bx
		inc diag
		loop di_cd		; el ciclo dibuja la diagonal
		pop cx
		pop bx
		ret

;---------------------

inigraf:
		; obtiene y guarda config de pantalla
		mov ax, 4f03h
		int 10h
		mov gmode, bx 
		; definir pantalla 1024x768, 256 colores
		mov ax, 4F02h
		mov bx, 105h	; código del modo
		int 10h
		ret

;---------------------

finGraf:
		; restaurar pantalla a config original
		mov bx, gmode
		mov ax, 4F02h
		int 10h
		ret

;---------------------
end
