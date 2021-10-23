[bits 32]

extern _blockAddr
extern _At
global _read
global _write

_read:

		pushfd
		and eax , 0x0FFFFFFF
		push eax
		push ebx
		push ecx
		push edx
		push edi

		mov eax , [_blockAddr]
		mov cl , 1
		mov edi , _At		

		mov ebx , eax
 
		mov edx , 0x01F6 
		shr eax , 24
		or al , 11100000b     
		out dx , al
 
		mov edx , 0x01F2      
		mov al , cl           
		out dx , al
 
		mov edx , 0x1F3       
		mov eax , ebx         
		out dx , al
 
		mov edx , 0x1F4       
		mov eax , ebx         
		shr eax , 8           
		out dx , al
 
 
		mov edx , 0x1F5       
		mov eax , ebx         
		shr eax , 16          
		out dx , al
 
		mov edx , 0x1F7       
		mov al , 0x20         
		out dx , al
 
.loop1:
		in al , dx
		test al , 8
		jz .loop1
 
		mov eax , 256         
		xor bx , bx
		mov bl , cl           
		mul bx
		mov ecx , eax         
		mov edx , 0x1F0
		rep insw             
 
		pop edi
		pop edx
		pop ecx
		pop ebx
		pop eax
		popfd
		ret


_write:
		pushfd
		and eax , 0x0FFFFFFF
		push eax
		push ebx
		push ecx
		push edx
		push edi

		mov eax , [_blockAddr]
		mov cl , 1
		mov edi , _At

		mov ebx , eax
 
		mov edx , 0x01F6
		shr eax , 24
		or al , 11100000b     
		out dx , al
 
		mov edx , 0x01F2      
		mov al , cl           
		out dx , al
 
		mov edx , 0x1F3       
		mov eax , ebx         
		out dx , al
 
		mov edx , 0x1F4       
		mov eax , ebx         
		shr eax , 8           
		out dx , al
 
 
		mov edx , 0x1F5       
		mov eax , ebx         
		shr eax , 16          
		out dx , al
 
		mov edx , 0x1F7       
		mov al , 0x30         
		out dx , al
 
.loop2:
		in al , dx
		test al , 8
		jz .loop2
 
		mov eax , 256         
		xor bx , bx
		mov bl , cl           
		mul bx
		mov ecx , eax 
		mov edx , 0x1F0
		mov esi , edi
		rep outsw            
 
		pop edi
		pop edx
		pop ecx
		pop ebx
		pop eax
		popfd
		ret
