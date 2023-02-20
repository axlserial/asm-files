;Versi�n 1.4
;1.4	fleeflo: lee n�mero flotante y lo pone en la pila (push)
;1.3	fleebcd: devuelve en AL car�cter con que termin� entrada, AH con n�m de s�mbolos
;	fleebcd: el signo se cambia con 's', en cualquier momento
;1.2	Eliminaci�n de variables que no hacen falta, mejoras en fdstacki
;1.1	Correcci�n de fdstackf, nombres de funciones y funciones para respaldo de pila
;1.0	En esta versi�n, fdstack desplega la pila, como enteros y los vuelte enteros
.model small
.386
public fdespflo	;Despliega dato flotante. Recibe mediante DX la direcci�n de la variable
public fleeflo	;Lee flotante del teclado y lo pone en la pila (push)
public fleebcd  ;Lee BCD de teclado, pone en memoria apuntada por DX, 18 digitos
public fdespbcd ;Despliega variable BCD de 80 bits, dir en DX
public fdstacki	  ;Despliega el contenido de la pila como enteros
public fdstackf   ;Despliega el contenido de la pila como flotantes

extrn	des4:near
extrn	des2:near
extrn	des1:near
extrn	reto:near
extrn	espa:near

.stack
.data
;variables necesarias para despliegue de flotantes
FTEN	dd	10.0
FCTRL	dw	?	;2 B, registro de control
FCTRLM	dw	0000110000000000b	;m�scara para habilitar truncamiento
;variables necesarias para desplegar pila de 387
FFLO	dd	?	;4 B, para copiar y desplegar contenido de pila
FBCD	dt	?	;10 B, entero BCD para despliegue

FMSVE	db	108 dup(?)
FDFSVE	db	108 dup(?)
separat	db	'-----------------------------------', 0Dh, 0Ah, 24h
indef	db	'       <indf>$'
FLFSIG	db	0	;Signo, para fleeflo
FLFT1	dw	0	;Temporal 1, para fleeflo
FLFTQ	dq	?	;Temporal Q, para fleeflo

.code

fdstackf:
	push ax cx dx
	
	;mov dx,offset separat
	;mov ah,09h
	;int 21h
	
	fsave FMSVE
	frstor FMSVE

	mov dx,offset FFLO
	mov cx,8
	
 fdsfc:	fstp FFLO
	call fdespflo
	;call reto
	call espa
	loop fdsfc
	call reto
	;mov dx,offset separat
	;mov ah,09h
	;int 21h

 	frstor FMSVE
 	pop dx cx ax
	ret
	
;funci�n que muestra el estado de la pila del coprocesador		
fdstacki:
	push ax cx dx
	
	mov dx,offset separat
	mov ah,09h
	int 21h
	
	fsave FMSVE	;Guarda contenido de pila 387
	frstor FMSVE	;Obtiene copia de pila 387 para su despliegue
	
	mov dx,offset FBCD
	mov cx,8
	
 fdsb1:	fbstp FBCD
 	call fdespbcd
 	call reto
	loop fdsb1
	
	jmp fdsbs

	
 fdsbs:
	frstor FMSVE	;Recupera contenido de pila 387
	fwait
		
	mov dx,offset separat
	mov ah,09h
	int 21h
	
	pop dx cx ax
	ret
;----------------------------------------------------
;Despliega flotante de 4 bytes en forma binaria
fdfbin:
	
;----------------------------------------------------
;Despliega n�mero flotante de 4 bytes ( FDD	dd	100.82 )
;Recibe direcci�n mediante apuntador en DX                                                  la pila [BP+4]
;Esta funci�n modifica el modo de redondeo (por truncamiento) y no lo restaura (podr�a).
fdespflo:
	pusha
	fsave FDFSVE
	
	fstcw FCTRL	;obtiene antiguo registro
	mov ax,FCTRL
	or ax,FCTRLM	;aplica m�scara para habilitar redondeo a cero (truncar)
	mov FCTRL,ax
	fldcw FCTRL	;aplica nuevo registro de control
	
	mov bx,dx	
	
	;desplegar parte entera
 fdf1:	fld dword ptr [bx]				;	FDD		;carga n�mero en la pila		FDD
	fld st(0)	;copia del n�mero en st(1)		FDD	FDD
	frndint		;obtiene entero sin redondeo		iFDD	FDD
	fld st(0)	;copia de entero			iFDD	iFDD	FDD
	
	fbstp FBCD	;entero sin redondeo			iFDD	FDD
	fwait
	
	;determinar si est� indefinido
	mov bx,offset FBCD
	;add bx,9
	mov dl,[bx+9]
	cmp dl,0FFh
	jne fdf2
	mov dx,offset indef
	mov ah,09h
	int 21h
	jmp fdfs
	;call desp2
	;call espa
	
 fdf2:	mov dx,offset FBCD
	call fdfdb	;deslegar dato BCD (parte entera)
	
	mov dl,'.'
	mov ah,02h
	int 21h

	mov cx,8
	;preparar para entrar en ciclo
	fsub						;	nFDD
	
 fdfc:	;desplegar flotantes
	;para entrar a este ciclo, hay que tener en:
	;	FDDA el n�mero que se va recorriendo
	fmul FTEN	;multiplico por 10.0			FDD*10
	fld st(0)	;copia del n�mero en st(1)		FDD	FDD
	frndint		;obtiene entero sin redondeo		iFDD	FDD
	fld st(0)	;copia de entero			iFDD	iFDD	FDD
	fbstp FBCD	;entero sin redondeo para despliegue	iFDD	FDD
	fwait
	
	mov bx,offset FBCD	;desplegar entero
	mov dl,[bx]
	call des1
	
	fsub		;retirar la parte entera		nFDD
	
	loop fdfc
	fbstp FBCD	;retirar �ltimo registro para vaciar la pila


 fdfs:	fwait
		
	frstor FDFSVE
	popa
	ret
	
;DX contiene la direcci�n de inicio de la cadena
 fdfdb:		;despbcd: desplegar parte entera
	push ax
	push bx
	push cx
	
	mov bx,dx
	mov cx,10
	add bx,9
	
	;desplegar signo si aplica
	mov dl,[bx]
	cmp dl,80h
	jne fdfdb1
	mov dl,'-'
	mov ah,02h
	int 21h
	dec bx
	dec cx
	;ciclo de d�gitos que no cuentan
 fdfdb1:	;dbcd1:	
 	;print "Entro a ceros que no cuentan$"
 	mov dl,[bx]
 	cmp dl,0	;si es un cero a la izquierda
 	jne fdfdb2	;salta si ya hay algo diferente de cero
 	
 	dec bx
 	dec cx
 	
 	cmp cx,0	;es el �ltimo?
 	jg fdfdb1	; no: repite
 	
 	call des1	; si:	desplegar '0' si es el �nico d�gito
 	jmp fdfdbs	;	y salir
 	;ciclo de d�gitos que s� cuentan 	
 fdfdb2:	
 	;print "Entro a ciclo de d�gitos que si cuentan$"
 	cmp dl,0Fh
 	jg fdfdb3	;si hay 2 d�gitos que desplegar
	call des1
	jmp fdfdb4
 fdfdb3:
 	call des2
 fdfdb4:
 	dec bx
 	dec cx
	;sale si ya fue lo �ltimo
 	cmp cx,0
 	je fdfdbs
 	 	
 fdfdb5:
 	mov dl,[bx]
 	call des2
 	dec bx
 	loop fdfdb5
 	
 fdfdbs:	pop cx
	pop bx
	pop ax
	ret
;------------------------------------------------------------------------------------
;Lee del teclado un n�mero BCD de hasta 18 digitos, con signo
;y lo copia a una variable cuya direcci�n est� en DX
;Dejar� en AL el ascii de la tecla final (enter,esc,+,-,*,/)
fleebcd:
	push bp
	mov bp,sp
	
	sub sp,02	;variable local [BP-2]
	;mov [bp-2],0	; L: s�mbolo de salida
			; H: contador de d�gitos recibidos
	
	;borrar variable
	mov di,dx	;en DX tenemos la direcci�n de variable donde se almacenar�
	mov al,0
	mov cx,10
	rep stosb

	mov bx,dx	;argumento: apuntador a variable BCD
	mov cx,0	;contador de d�gitos recibidos
	mov dh,0	;bandera del signo
	

	;ciclo de lectura
 lbcdpu:cmp cx,18	;ya no hay cabida para m�s n�meros
	je lbcdps	; ir a siguiente fase, acomodar datos le�dos
	
 	call lee1b_ne	;leer 1 d�gito, BCD, o ascii de s�mbolo
 	
	;detectar cambio de signo
	cmp al,'s'	;es tecla para cambio de signo?
	jne lbcd2	; no: salta a siguiente paso
	
	;cambiar el signo en variable
	mov al,byte ptr[bx+9]
	xor al,80h
	mov byte ptr[bx+9],al
	;bandera del signo
	xor dh,1
	
	call alinea
	jmp lbcdpu
	
	;detectar si es d�gito v�lido
 lbcd2: cmp al,9	;es n�mero
 	jle lbcdpn	; si: salta a procesar digito
 	mov ah,cl	;contador de d�gitos introducidos
 	mov [bp-2],ax	;variable local: s�mbolo utilizado (0Dh=enter)
 	jmp lbcdps	;salta a inicio de proceso de salida
 

		
	;es n�mero
 lbcdpn:push ax		;lo guarda en la pila
	inc cx		;e incrementa el contador
	;;;manejo del cursor
	call alinea
	;;;
	jmp lbcdpu
	
	;Extraer de pila n�meros introducidos y acomodarlos:
	; BX apuntador a vector
	; CX contador de digitos leidos
	; AL numero leido
	; DL indica si colocar� en la parte alta o baja
 lbcdps:call reto
	mov dl,0	;parte baja
	
	cmp cx,0	;si pila vac�a
	je lbcds	;	salir
	
 lbcdpo:pop ax
	cmp dl,0	;parte baja?
	jne lbcdpa

	mov [bx],al	;baja
	mov dl,1		;siguiente ser� alta
	jmp lbcd1
 lbcdpa:shl al,4
 	add al,[bx]	;alta
 	mov [bx],al
 	mov dl,0		;siguiente ser� baja
 	inc bx
 lbcd1:	loop lbcdpo
	
 lbcds:	mov ax,[bp-2]	;poner en AX el s�mbolo utilizado para salir
 	mov sp,bp
 	pop bp
 	ret
 
;;;;;;;;;;;
;cx contiene el contador, ser� respaldado
;dh contiene bandera del signo
;pila contiene los datos guardados
alinea:

	push bp
	mov bp,sp
	push ax bx cx dx
	
	mov bx,cx	;bx es respaldo de contador
	mov cx,20	;18 mas signo y un espacio
	sub cx,bx	;espacios en blanco
	cmp dh,1
	jne als0
	dec cx
	
 als0:	mov ah,02h
	mov dl,0dh
	int 21h		;regresar a la izquierda
	mov dl,' '
 alcb:	int 21h		;rellenar de blancos
 	loop alcb
 	
 	cmp dh,1
 	jne als1
 	mov dl,'-'
 	int 21h
	
 als1:	mov cx,bx	;recarga contador
	cmp cx,0
	je alsa
	
 alcl:	mov si,cx
 	dec si
	shl si,1
	add si,4
	mov dl,[bp+si]
	add dl,30h
	int 21h
	;call desp1
	loop alcl
	
 alsa:	pop dx cx bx ax
	pop bp

	ret

 ;Despliega el contenido de una variable BCD de 80 bits, positivo y negativo
;	pendiente: Restringir a 18 digitos
;DX contiene la direcci�n de inicio de la cadena
fdespbcd:
	push bx
	push cx
	push dx
	
	call espa
	mov dh,0	;bandera de signo
	
	mov bx,dx
	mov cx,9
	add bx,9
	
	mov al,[bx]
	cmp al,0FFh	;n�mero indeterminado
	jne dbcdci
	mov dx,offset indef
	mov ah,09h
	int 21h
	jmp dbcds
	
	;procesar signo
 dbcdci:mov al,[bx]
	dec bx
	and al,80h
	jz dbcdcns
	
	mov dh,1	;signo negativo
	;mov dl,'-'
	;mov ah,02h
	;int 21h
	jmp dbcdc0
	
 dbcdcns:call espa	;espacio extra para positivos
 	
	;saltarse los pares 00
 dbcdc0:mov dl,[bx]
	cmp dl,0
	jne dbcdc1
	dec bx
	call espa
	call espa
	loop dbcdc0
	
	;si no queda nada, salir
	cmp cx,0
	jne dbcdc1
	mov dl,0
	call des1
	
	jmp dbcds
	;si el primero es menor a 10h, s�lo desplegar primer d�gito
 dbcdc1:mov dl,[bx]
 	mov al,dl
 	and al,0F0h
	;cmp dl,0Fh
	jnz dbcds2	;salta si hay dos n�meros
	
	;hay uno
	call espa	;espacio para llenar le hueco
	;si hay signo, desplegarlo
	cmp dh,1
	jne dbcdc2
	push dx
	mov dl,'-'
	mov ah,02h
	int 21h
	pop dx
	mov dh,0
	;despliega numero solitario
 dbcdc2:call des1

	dec bx
	dec cx
	
	;si no queda nada, salir
	cmp cx,0
	je dbcds
	;desplegar los pares restantes

 dbcds2:;comprobar signo pendiente
 	cmp dh,1
	jne dbcdc
	mov dl,'-'
	mov ah,02h
	int 21h
	mov dh,0
	
 dbcdc:	mov dl,[bx]
	call des2
	dec bx
 	loop dbcdc
	
 dbcds:	pop dx
 	pop cx
	pop bx
	ret
;----------------------------------------
lee1b_ne:mov ah,07h
	int 21h
	
	cmp al,30h
	jl l1nes
	cmp al,39h
	jg l1nes
	sub al,30h
	
 l1nes:	ret

;------------------------------------------------------------------------------------
;Lee del teclado un n�mero flotante, con signo
;y lo pondr� en la punta de la pila del coprocesador
;[[[Dejar� en AL el ascii de la tecla final (enter,esc,+,-,*,/)]]] (todav�a no)
fleeflo:		
	fsave FDFSVE	
	fwait
	fldz		;Acumulador=0
	mov FLFSIG,0	;bandera del signo?
	xor ax,ax	;Borra AX
 
 	mov ah,01h	;leer caracter
 	int 21h
 			;verificar si es menos
 	cmp al,'-'
	jne flf_1
	mov FLFSIG,0ffh	;si es negativo, poner FF en bandera del signo
	jmp flf_2

 flf_1:	cmp al,'+'	;verificar si es mas
	je flf_2;paso3	;convertir a numero
	cmp al,'0'	;checar si es numero
	jl flf_s;paso2	;salir si el teclado es otra cosa
	cmp al,'9'
	jg flf_s;paso2
 	jmp flf_3;paso4	; esto confirma que si es un numero

 flf_2:	mov ah,01h	;leer caracter
	int 21h

 flf_3:	cmp al,'.'	;probar para ver si es flotante
	je flf_5	;convertimos a decimales
	cmp al,'0'	;probar para numero
	jl flf_4
	cmp al,'9'
	jg flf_4
			;Es n�mero. Hacer:
	fmul FTEN	;multiplica acumulador por 10
	xor ah,ah	;asignamos a ah 0
	sub al,'0'	;convertimos el codigo ascii a numero
	mov FLFT1,ax
	fiadd FLFT1
	jmp flf_2
 			
 flf_4:	cmp FLFSIG,0	;si es negativo
 	je flf_s
 	fchs		;cambiar signo
 	jmp flf_s		
 			
 flf_5:	fld1		;cargar 1.		Pila: 1 	- acum
 	fdiv FTEN	;dividir/10		Pila: 0.1 	- acum
	
 flf_6:	mov ah,01h	;leer caracter
 	int 21h
 	cmp al,'0'	;probar para numero
 	jl flf_7
 	cmp al,'9'
 	jg flf_7
 			;Es n�mero. Hacer:
 	xor ah,ah	;asignamos a ah 0
 	sub al,'0'	;convertimos el codigo ascii a numero
 	mov FLFT1,ax
 	fild FLFT1	;cargar numero
 	fmul st,st(1)	;forma de decimal
 	fadd st(2),st
 	fcomp
 	fdiv FTEN
 	jmp flf_6

 flf_7:	fcomp		;limpiar pila???
 	jmp flf_4

 flf_s: fst FLFTQ	;guarda temporalmente aqu�
 	frstor FDFSVE	;Revisar: por qu� no respeta la pila anterior, haciendo necesario frstor
 	fld FLFTQ	;recupera y deja en pila
 	fwait
 	ret
end