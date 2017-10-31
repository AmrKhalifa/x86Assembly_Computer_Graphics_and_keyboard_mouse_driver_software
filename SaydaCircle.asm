
_circle:
	mode13h:
	mov ah, 0
	mov al , 0x13
	int 0x10
	;jmp drawCircle
	
	
	mov word [circolor],1
	mov word [x2Circle], 160
	mov word [y2Circle] , 100
	mov word [radius] ,75
	mov word [errCircle ],  0
	mov word [xCircle], 0
	mov word [yCircle], 0
	mov word [tempxCircle], 0
	mov word [tempyCircle], 0
	
	
	jmp beginDrawingCircles
	
	delay:
	mov eax , 1000
	delayLoop:
	dec eax 
	cmp eax , 0
	jge delayLoop
	ret
	
	
	myCirclePixel:
	
				mov ah , 0Ch
				mov al ,  byte [circolor]
				mov cx ,  [tempxCircle]
				mov dx ,  [tempyCircle]
				int 10h
				ret

	drawCircle:
	mov ax , [radius]
	mov word [xCircle] , ax 
	mov word [yCircle] ,   0
	mov word [errCircle] ,	0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	drawLoop:
	mov ax , [x2Circle]
	add ax , [xCircle]
	mov [tempxCircle], ax
	mov bx , [y2Circle]
	add bx , [yCircle]
	mov [tempyCircle] , bx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax , [x2Circle]
	add ax , [yCircle]
	mov [tempxCircle], ax
	mov bx , [y2Circle]
	add bx , [xCircle]
	mov [tempyCircle] , bx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax , [x2Circle]
	sub ax , [yCircle]
	mov [tempxCircle], ax
	mov bx , [y2Circle]
	add bx , [xCircle]
	mov [tempyCircle] , bx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax , [x2Circle]
	sub ax , [xCircle]
	mov [tempxCircle], ax
	mov bx , [y2Circle]
	add bx , [yCircle]
	mov [tempyCircle] , bx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax , [x2Circle]
	sub ax , [xCircle]
	mov [tempxCircle], ax
	mov bx , [y2Circle]
	sub bx , [yCircle]
	mov [tempyCircle] , bx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax , [x2Circle]
	sub ax , [yCircle]
	mov [tempxCircle], ax
	mov bx , [y2Circle]
	sub bx , [xCircle]
	mov [tempyCircle] , bx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax , [x2Circle]
	add ax , [yCircle]
	mov [tempxCircle], ax
	mov bx , [y2Circle]
	sub bx , [xCircle]
	mov [tempyCircle] , bx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov eax , [x2Circle]
	add eax , [xCircle]
	mov [tempxCircle], eax
	mov ebx , [y2Circle]
	sub ebx , [yCircle]
	mov [tempyCircle] , ebx
	call myCirclePixel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp word [errCircle], 0
	jge errBigger
	inc word [yCircle]
	mov ax ,[yCircle]
	shl ax , 1
	inc ax
	add [errCircle] , ax
	jmp done
	errBigger:
	dec word [xCircle]
	mov ax , [xCircle]
	shl ax ,1
	inc ax
	sub [errCircle],ax	
	done:
		mov ax , [xCircle]
		cmp ax , [yCircle]
		jg drawLoop
 ret  
 
 beginDrawingCircles: 
 xor esi ,esi 
 loop1:
 dec word [radius]
 inc word [circolor]
 xor eax, eax 
 loopDelay:
 inc eax 
 cmp eax ,10000000
 jl loopDelay
 call drawCircle
 add esi ,1
 cmp esi ,75
jl loop1

cli
				circleCheckKey:
					in al, 0x64;
					and al, 1;
					jz circleCheckKey
					in al , 0x60
					cmp al , 0x81
					jz _exit
					jmp circleCheckKey		

 
	circolor : dw 1
	x2Circle : dw 160
	y2Circle : dw 100
	radius : dw 75
	errCircle : dw 0
	xCircle : dw 0
	yCircle : dw 0
	tempxCircle : dw 0
	tempyCircle : dw 0
 
 