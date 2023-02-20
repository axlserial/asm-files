.model small

.386
extrn fleeflo:near
extrn fdespflo:near
extrn reto:near

.stack

.data
num	dd	?
num2	dd 2
res	dd	?

.code
main:	mov ax, @data
		mov ds, ax
		mov es, ax

		mov eax, 5
		mov num, eax

		finit
		fild num
		fild num2
		fmul
		fst res

		fwait
		lea dx, res
		call fdespflo
		call reto

		.exit 0
end