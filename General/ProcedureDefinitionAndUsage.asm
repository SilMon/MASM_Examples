; Hello World program using the win32 API
.386
.MODEL flat, stdcall
; Define output handle  -> predefined constant see (https://docs.microsoft.com/de-de/windows/console/getstdhandle)
STD_OUTPUT_HANDLE EQU -11 
; Define structure of called functions
; Function to get the handle for the standard device (console)
GetStdHandle PROTO, nStdHandle: DWORD 
; handle: Handle for console screen buffer
; lpBuffer: Pointer to the buffer containing the chars to write
; nNumberOfBytesToWrite: The number of characters to be written
; lpReserved: Reserved, must be NULL.
WriteConsoleA PROTO, handle: DWORD, lpBuffer:PTR BYTE, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:PTR DWORD, lpReserved:DWORD
; dwExitCode: The exit code for the process and all threads -> see (https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess)
ExitProcess PROTO, dwExitCode: DWORD 

; Define used variables and constants
.data
; Define variables used for printing 
; Handle to the standard output device (console screen buffer)
consoleOutHandle DWORD ? 
; Number of written Bytes
bytesWritten DWORD ?

; Define the code to execute
.code
; Define main function
main PROC
; Call the defined printing function with message, length of message
CALL print "Example for procedure definition and calling!", 45
; Finsih the main function
main ENDP

;--------------------------------------------------------
; Define function for printing to the console
; Arguments:
; message: The message to print
; lmessage: The length of the message
; Return: Nothing
;--------------------------------------------------------
print PROC message: BYTE, lmessage: DWORD
; Get the standard handle
INVOKE GetStdHandle, STD_OUTPUT_HANDLE
; Set eax as the output handle
mov consoleOutHandle, eax 
; Move message with offset to data register
mov edx, offset message 
; Push the content of all General Purpose Registers to the stack
pushad    
; Move the message length to eax
mov eax, lmessage
; Invoke writing to console screen
INVOKE WriteConsoleA, consoleOutHandle, edx, eax, offset bytesWritten, 0
; Pop all double words (dwords) from the stack into the General Purpose Registers
popad
; Exit the WriteConsoleA function
INVOKE ExitProcess, 0 
print ENDP
; Finish the program
END main
