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
	dividendMsg BYTE "Dividend (Lucas Number):", 0
	divisorMsg BYTE "Divisor (Lucas Number - 1):", 0
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

	
	push nInput			;Calculating Lucas(n)
	call calcLucas
	add esp, 8
	mov lucasNum, eax

	mov eax, nInput		;Calculating Lucas(n-1)
	mov edx, 1
	sub eax, edx		;output in eax
	push eax
	call calcLucas
	add esp, 8
	mov lucasNumM, eax





	;display the divident and divsor

	lea ebx, dividendMsg
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

	ret

calcLucasRatio ENDP

calcLucas PROC C

	push ebp
	mov ebp, esp

	sub  esp, 4 

	mov eax, [ebp + 8]

	;Now calculate the lucas number
	
	cmp eax, 0		;IF nInput = 0
	JE zeroInput	
		
	cmp eax, 1		;IF nInput = 1
	JE oneInput

	cmp eax, 1		;IF nInput > 1
	JA greaterInput






	zeroInput:			;set lucas to 2
	mov eax, 2
	;push 2
	pop ebp
	ret

	;return lucas here

	
	oneInput:			;set lucas to 1
	mov eax, 1
	;push 1
	pop ebp
	ret
		
	;return lucas here




	;Here I need to do n-1 first, then n-2. Once I have the new N value, then call calcLucas(N) and get the returned value. This should recursively get the correct value.

	greaterInput:		;Do n-1 + n-2 = lucas
	;mov eax, [ebp + 8]
	;mov edx, 1
	;sub eax, edx		;output in eax

	;push eax
	;call calcLucas
	;add esp, 4
	;mov [ebp-4], eax

	;mov eax, [ebp + 8]
	;mov edx, 2
	;sub eax, edx

	;push eax
	;call calcLucas
	;add esp, 4
	;mov lucasNum, eax
	;mov ebx, [ebp-4]

	;add eax, ebx		;add, results stored in eax 

	dec eax
    push eax            ; Fib(n-1)
    call calcLucas
    mov [ebp-4], eax    ; store first result

    dec dword ptr [esp] ; (n-1) on the stack -> (n-2)
    call calcLucas
    add esp, 4          ; clean up stack

    add eax, [ebp-4]    ; add result and stored first result

	pop ebp
	ret

	;return lucas here






calcLucas ENDP


END
