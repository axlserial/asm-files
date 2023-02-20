.model small
extrn reto:near
extrn des4:near
.stack
.data
; DTA, para manipular directorios

patron db "negado.*",0
DTA db 21 dup(0)
attr db 0
time dw 0
date dw 0
sizel dw 0
sizeh dw 0
fname db 13 dup(0)

; Para manipular de archivos

buffer	db 100h	dup (?)		
fid	dw ?

.code

main: 	mov ax,@data
		mov ds,ax
		mov es,ax

		; Para Abrir el directorio actual
		; Establecer posición de DTA

		mov ah,1Ah
		mov dx,offset DTA
		int 21h

		; Preparar lectura de directorio y mostra primer archivo

		mov dx,offset patron	; patrón de búsqueda
		mov cx,0 				; Archivos normales
		mov ah,4Eh 				; Buscar primer archivo que cumpla
		int 21h					; Mostrar archivo
		jc finn					; Si no comple, terminar programa

		mov ah,3Dh				; Código para abrir un archvio 
		mov al, 0h				; Modo lectura
		mov dx, offset fname	; Dirección del nombre del archivo
		int 21h					; Abrir, devuelve identificador
		jc error				; En caso de error, saltar a 'error'
		mov fid, ax				; guardar identificador
		
		; Bloque para leer archivo (3FH)

		mov ah, 3Fh				; Código para leer archivo
		mov bx, fid				; Identificador
		mov cx, 0FFh			; Tamaño deseado 100h - 1h, 
								; el 1 se reserva para '$'  
		mov dx, offset buffer	; Dirección buffer
		int 21h					; Leer archivo
		jc error

		; Colocar simbolo '$' al final de cadena leída
		mov bx, ax
		add bx, offset buffer
		mov byte ptr [bx], '$'

		mov cx, ax				; Tamaño de la cadena
		mov al,'n'				; Primera letra de no 'n' → al
		cld						; Autoincremento 
		mov di, offset buffer	; Dirección de 'buffer' → di
	
leer:			
		repne scasb				; Copia en [si] lo que esta en al, 'n'
								; incrementa cx → si llega 0 termina
								; Si encuentra 'n', avanza a la sig. posición
								; y en [di-1] está la 'n'
		cmp cx,0				; Comparar si llegamos al final del archivo
		je 	desplegar			; Desplegamos

		cmp byte ptr [di], 'o'	; Si encuentra 'n', Buscar 'o' en [di] (posición actual)
		jne leer				; Si no se encuentra, no existe "no", regresar a leer
	
		dec di					; Para remplazar 'n' con un espacio 
		mov byte ptr [di], ' '	; decrementamos en uno la posición de [di]
		inc di					; Para remplazar la 'o' con un espacio
		mov byte ptr [di], ' '	; incrementamos en uno la posición de [di]
		jmp leer

desplegar:		
		
		mov dx, offset buffer
		mov ah, 09h
		int 21h

		call reto
		
		; Cierre del archivo actual
		; el archivo actual

		mov ah, 3Eh				; Código para cerrar archivo
		mov bx, fid				; Identificador
		int 21h					; Cerrar archivo
		jc error				; Saltar en caso de error
		jmp finn
		
error:	; En caso de error, se despliega el codigo de error. 

		mov dx, ax				; Desplegar código de error
		call des4				; Codigo de error
		.exit 1					; Y salir indicando que hubo error
		
finn: 	
		.exit 0					; Salida

end
