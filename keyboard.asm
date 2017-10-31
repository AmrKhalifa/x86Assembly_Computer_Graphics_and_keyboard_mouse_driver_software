theBigLoop:
	
	 xor eax , eax 
	 mov edi, 0xB8000
	 mov esi, 0xB8000
	 xor ebx,ebx
	 mov edx, WelcomString
	 loop0:
	 mov al, [edx];
	 mov byte [edi], al;
	 inc edi;
	 inc edi;
	 inc edx;
	 inc bx;
	 call cursor
	 cmp byte[edx],0;
	 jne loop0;
	 
check_key:
	in  al , 0x64;
	and al, 1;
	jz check_key
	in al, 0x60;
	mov bl , al 
	cmp bl , 0x82
	je _activateMouse
	cmp al , 0x83
	je _activeKeyboard
	call _clearScreen
	jmp theBigLoop
	;jmp check_key
	
cursor :
pushad
mov al,0x0f
mov dx,0x03D4
out dx,al

mov al,bl
mov dx,0x03D5
out dx,al

xor eax,eax

mov al,0x0e
mov dx,0x03D4
out dx,al

mov al,bh
mov dx ,0x03D5
out dx,al

popad
ret

_clearScreen :
	cmp edi,0xB8000
	je l4
	loop3:
	mov al,0x20
	mov [edi],al
	sub edi,2
	cmp edi,0xB8000
	jg loop3
	
l4:
	xor ebx,ebx
	call cursor
	ret

_exit :
		cli
		mov ah , 0
		mov al , 3h
		int 0x10

	call _clearScreen
	jmp theBigLoop
	
_activateMouse :
jmp mouse	

_activeKeyboard:
	call _clearScreen
	mov edx, keyboardString;
	loop4:
	mov al, [edx];
	mov byte [edi], al;
	inc edi;
	inc edi;
	inc edx;
	inc ebx
	call cursor
	cmp byte[edx],0;
	jne loop4;
	
check_key1:
	in al, 0x64;
	and al, 1;
	jz check_key1
	;If pressed get key
	in al, 0x60;
	cmp al,0x1C
	jne l2

l2:
	cmp al,0x01
	je _exit
	cmp al,0x36
	jg _activeKeyboard
	cmp al , 0xBA
	je _activeKeyboard
	cmp al , 0x0E
	je _activeKeyboard
	cmp al , 0x0F
	je _activeKeyboard
	cmp al , 0x39
	je _activeKeyboard
	cmp al , 0x36
	je _activeKeyboard
	cmp al , 0x2A
	 je _activeKeyboard
	
	cmp al, 0x02
	je _lines
	cmp al, 0x03
	je _triangle
	cmp al, 0x04
	je colorFul_rectangles
	cmp al, 0x05
	je _circle
	call _clearScreen
	jmp _activeKeyboard	

	keyboardString : db "press 1 for diagonal line , 2 for triangles , 3 for rectangles , 4 for circle   press ESC anywhere  in Shapes mode to return to main menu",0
	WelcomString: db "press 1 for mouse free drawing , 2 to choose between Shapes ",0