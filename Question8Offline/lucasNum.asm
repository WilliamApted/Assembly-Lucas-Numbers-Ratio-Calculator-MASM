; A simple template for assembly programs.
.386  ; Specify instruction set
.model flat, stdcall  ; Flat memory model, std. calling convention
.stack 4096 ; Reserve stack space

	readInteger PROTO C
	printInteger PROTO C
	printString PROTO C

.data ; data segment
	
	nInput DWORD 5
	lucasNum DWORD 0
	lucasNumM DWORD 0
	quotient DWORD 0
	remainder DWORD 0


	firstPrompt BYTE "Enter an integer 'n':", 0
	dividendMsg BYTE "Dividend (Lucas Number(n)):", 0
	divisorMsg BYTE "Divisor (Lucas Number(n-1)):", 0
	quotientMsg BYTE "Quotient (Calculated Ratio):", 0
	remainderMsg BYTE "Remainder:", 0
	   	
.code ; code segment

calcLucasRatio PROC C

	
	lea ebx, firstPrompt		;prompt for user input of 'n'
	push ebx
	call printString
	add esp, 4

	call readinteger			;now read user input
	mov nInput, eax

	;Now calucate Lucas(n) and Lucas(n-1)

	
	push nInput			 ;Calculating Lucas(n)
	call calcLucas
	add esp, 4
	mov lucasNum, eax

	mov eax, nInput		 ;Calculating Lucas(n-1)
	mov edx, 1
	sub eax, edx		 ;output in eax
	push eax
	call calcLucas
	add esp, 8
	mov lucasNumM, eax


	

	lea ebx, dividendMsg ;display the divident and divsor
	push ebx
	call printString
	add esp, 4

	mov ebx, lucasNum
	push ebx
	call printInteger
	add esp, 4

	lea ebx, divisorMsg
	push ebx
	call printString
	add esp, 4

	mov ebx, lucasNumM
	push ebx			;Printing the divisor
	call printInteger	
	add esp, 4

	;now do lucas(n)/lucas(n-1), providing an answer with a remainder

	mov edx, 0 
	mov eax, lucasNum
	mov ecx, lucasNumM
	div ecx				;does eax/ecx = (in eax) remainder (in edx)

	mov quotient, eax
	mov remainder, edx


	lea ebx, quotientMsg
	push ebx
	call printString
	add esp, 4

	mov ebx, quotient
	push ebx			;Printing the ratio. Held in eax.
	call printInteger
	add esp, 4
	
	lea ebx, remainderMsg
	push ebx
	call printString
	add esp, 4

	mov ebx, remainder
	push ebx			;Printing the remainder. Held in edx.
	call printInteger
	add esp, 4

    pop ebp   
	ret

calcLucasRatio ENDP



calcLucas PROC C

	add ecx,1
    push ebp
    mov  ebp,esp
    sub  esp, 4         
    mov  eax,[ebp+8]    ; get n

    cmp  eax,0          ; Check if input is 0, if so will return 2
    JE   RetTwo
    cmp  eax,1          ; Check if input is 1, is so will return 1
    JE   RetOne

    dec eax				; Now do Lucas(n-1)
    push eax            
    call calcLucas
    mov [ebp-4], eax    ; store the result of Lucas(n-1)

    dec dword ptr [esp] ; Now do Lucas(n-2), decrementing by 1 from the previous decrement
    call calcLucas
    add esp, 4         

    add eax, [ebp-4]    ; Add together the result of Lucas(n-2) and Lucas(n-1)

    jmp ReturnLucas

	RetTwo:
    mov eax, 2          
	jmp ReturnLucas

	RetOne:
    mov eax, 1          
	jmp ReturnLucas
	
	ReturnLucas:
    mov esp, ebp       
    pop ebp             

    ret                 ; Then return

calcLucas ENDP

END
