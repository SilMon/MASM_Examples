; Program to demonstrate console IO using C functions
; Load needed libraries
includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
		.686
		.model flat, c
		.stack 100h
; Define prototypes of printf and scanf function
printf	PROTO arg1:PTR BYTE, printlist:VARARG
scanf	PROTO arg2:PTR BYTE, inputlist:VARARG
		.data
; Define format strings
in1fmt	byte "%d", 0
msg1fmt	byte 0Ah, "%s%d", 0Ah, 0Ah, 0
; Define messages
msg0	byte "Please enter and integer: ", 0
msg1	byte "The number is: ", 0
; Define variable for the input number
number	sdword ?
		.code
main	proc
		; Call print function to display message
		INVOKE printf, ADDR msg0
		; Call scan function to get user input. Input will be stored in the variable number
		INVOKE scanf, ADDR in1fmt, ADDR number
		INVOKE printf, ADDR msg1fmt, ADDR msg1, number
		ret
main	endp
		end
