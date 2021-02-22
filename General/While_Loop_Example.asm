; Program to illustrate the usage of while loops via compare and jump instructions
; The program calculates the little gauss for the given number
;-----------------------------------------------------------------------------------
; Load needed libraries for C console IO
			includelib msvcrt.lib
			includelib legacy_stdio_definitions.lib
			.686
			.model flat, c
			.stack 100h
; Define prototypes of printf and scanf function
printf			PROTO arg1:PTR BYTE, printlist:VARARG
scanf			PROTO arg2:PTR BYTE, inputlist:VARARG
			.data
; Define all console messages and their formats
msg1			BYTE "Please enter a number: ", 0
msg2			BYTE "Little gauss: ", 0
msg3			BYTE "Overflow occured, program aborted!", 0
msg2fmt			BYTE "%s%d", 0
in1fmt			BYTE "%d", 0
; Variable for the input number
number			DWORD ?
			.code
main			proc
			; Display input message
			INVOKE printf, ADDR msg1
			; Read the input number
			INVOKE scanf, ADDR in1fmt, ADDR number
			; Initialize eax to hold the little gauss
			MOV eax, 0
			; Initialize ecx t ohold the 
			MOV ecx, 1
			; Calculate the little gauss for the given number
while01:		CMP ecx, number
			; If the index is greater than number, jump to the end of the loop
			JG endwh01
			; Add the value of ecx to eax
			ADD eax, ecx
			; Check of integer overflow (Carry flag checked because Number is assumed to be unsigned)
			JC endwh02
			; Increase ecx
			INC ecx
			; Jump back to the start for a new run
			JMP while01
			; If overflow occured, inform the user
endwh01:		INVOKE printf, ADDR msg2fmt, ADDR msg2, eax
			; Jump to the end of the function
			jmp mainret
			; If no overflow occured, display little gauss
endwh02:		INVOKE printf, ADDR msg3
mainret:		RET
main			endp
			end
