mouse:	

	  cli
	  mov ax,13h 	; mode = 13h 
     int 10h 	    ; call bios service
	;enable mouse
		xor        eax, eax
      call        WriteMouseWait
      mov         al, 0xa8
      out         0x64, al
	   
	  ;restore default settings
	   mov         al, 0xf6
      call        MouseWrite


	   ;enable mouse
	   mov         al, 0xf4
      call        MouseWrite
	   
	   
	   
	  ;Main
	  
	  xor         ecx, ecx
     xor         eax, eax
	   
	  waitkey: 
	   in          al, 0x64
      and         al, 0x20
      jz          waitkey
	 
	 
	   cmp        byte[LEFTbutton],0x00
	   jne        hom
	   mov ah,0Ch 	; function 0Ch
	   mov al,0 	; color 4 - black
	   mov cx,[xmouse] 	; x position 
	   mov dx,[ymouse] 	; y position 
	   int 10h 	;    call BIOS service
   
       hom:
	   call        MouseRead
       mov         byte [k], al    ;get k
	   and         al,0x01
	   mov         [LEFTbutton],al
	  
	  ;get delta x
	  xor         ax,ax
	  xor         dx,dx
	  call        MouseRead
	  movsx       dx,al
	  mov         ax,dx
      add         [xmouse], ax
	  
	  
	  cmp         word[xmouse],0  ;borders
	  jg          here
	  mov         word[xmouse],0
	  
	  here:
	  cmp         word[xmouse],319 ;borders
	  jl          here2
	  mov         word[xmouse],319

	  here2:
	  
	  ;get delta y
	  xor         ax,ax 
	  xor         dx,dx
      call        MouseRead
	  movsx       dx,al
	  mov         ax,dx
      sub         [ymouse], ax  
      
	  
	  cmp         word [ymouse],199  ;borders
	  jl          here3
	  mov         word[ymouse],199
       
	  here3:
	  cmp         word [ymouse],0   ;borders
	  jg          here4
	  mov         word [ymouse],0
	  
	  here4:
	  call        MouseRead      ;get z
      mov         byte [z], al
	
       cmp        byte[LEFTbutton],0x00
	   je         her
	   mov        al,14	; color 5 - purple
	   jmp        no
	   
	   her:
	   mov       al,10 	; color 10 - green
	   no:
	   mov       ah,0Ch 	; function 0Ch
	   mov       cx, [xmouse]	; x position 
	   mov       dx, [ymouse]	; y position 
	   int       10h 	    ; call BIOS service
    
	   jmp waitkey
	  
			
WriteMouseWait:
	  mov        ecx, 1000
	strt1:  
      in         al, 0x64
      and        al, 0x02
      jz         fin1    
      dec        ecx
	  cmp        ecx,0
	  jnz        strt1
	  
    fin1:
	  ret
	  
ReadMouseWait:
	  mov        ecx, 1000
	strt2:  
      in         al, 0x64
      and        al, 0x01
      jnz        fin2    
      dec        ecx 
	  cmp        ecx,0
	  jnz        strt2
	 
    fin2:
	  ret
	
	MouseRead:
      call         ReadMouseWait
      in           al, 0x60
      ret
	
	MouseWrite:
      mov         dh, al
      call         WriteMouseWait
      mov         al, 0xd4
      out         0x64, al
      call         WriteMouseWait
      mov         al, dh
      out         0x60, al
      call         ReadMouseWait
      in         al, 0x60
      ret	  
	  	
xmouse: dw 0      
ymouse: dw 0
z: dw 0
k: dw 0
LEFTbutton: db 0