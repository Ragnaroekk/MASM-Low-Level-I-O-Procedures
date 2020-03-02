TITLE Ray's Low I/O Level Procedures      (Program_6.asm)

; Author: Ray Franklin
; Last Modified:	02/27/2020
; OSU email address: franklip@oregonstate.edu
; Course number/section: CS271-400
; Project Number:       6          Due Date:	03/15/2020
; Description: A portfolio assignment
; Implement and test your own ReadVal and WriteVal procedures for signed integers. 
; Implement macros getString and displayString.  
; The macros may use Irvine’s ReadString to get input from the user, 
; and WriteString to display output.  
; 	getString should display a prompt, 
; 		then get the user’s keyboard input into a memory location 
; 	displayString 
; 		should print the string which is stored in a specified memory location.  
; 	readVal should invoke the getString macro to get the user’s string of digits.  
; 		It should then convert the digit string to numeric, while validating the user’s input.  
; 	writeVal should convert a numeric value to a string of digits, 
; 		and invoke the displayString macro to produce the output. 
; Write a small test program that gets 10 valid integers from the user and 
; stores the numeric values in an array.  The program then displays the integers, 
; their sum, and their average. 
; We will be testing this program with positive and negative values.
; 1) 1 point: number each line of user input and display a running subtotal of the user’s numbers.  
; 2) 3 points: implement procedures ReadVal and WriteVal  for floating point values, using the FPU. 

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

intro_1     BYTE	"PROGRAMMING ASSIGNMENT 6: Designing low-level I/O procedures", 10, 13, 0
intro_2		BYTE	"Authored by: Ray Franklin", 10, 13, 0
intro_3		BYTE	"Please provide 10 signed decimal integers." , 10, 13, 0
intro_4 	BYTE	"The numbers should each fit inside a 32 bit register.", 10, 13, 0
intro_5 	BYTE	"Once you have entered the numbers, you will see them displayed as a list,", 10, 13, 0
intro_6 	BYTE	"next you will see the sum, and finally the average displayed.", 10, 13, 0
entry_1		BYTE	"Please enter a signed number: "
error_1		BYTE	"ERROR: You did not enter a valid signed number or the size was too large."
outro_1		BYTE	"Thanks for using my program, goodbye!", 0

.code
main PROC

; Display the title and programmer's name along with the instructions
	push	OFFSET	intro_1	; header information
	push	OFFSET	intro_2	; Author info
	push	OFFSET	intro_3	; input request
	push	OFFSET	intro_4	; The numbers should....
	push	OFFSET	intro_5	; Once you have...
	push	OFFSET	intro_6	; Next you will...
	call	introduction



; Say farewell to the user
	push	OFFSET	outro_1	; Thanks for...
	call	farewell

	exit	; exit to operating system
main ENDP

;****************************************
;Procedure to introduce the program to the user.
;receives: address of intro_1, intro_2, intro_3, intro_4,
;	intro_5, intro_6
;returns: none
;preconditions:  none
;registers changed: edx
;postconditions: The greeting message 
;	and program description is displayed
; ebp		epb old
; ebp+4		ret	
; ebp+8		@intro_6
; ebp+12	@intro_5
; ebp+16	@intro_4
; ebp+20	@intro_3
; ebp+24	@intro_2
; ebp+28	@intro_1
; ebp+32	edx
;****************************************

introduction	PROC
; Display the program title and programmer’s name. 
	push	ebp	; set up stack frame	
	mov		ebp,esp   
	push	edx	; save the edx register
	mov edx,	[ebp+28]	; header info
	call    WriteString
	mov edx,	[ebp+24]	; author info
	call    WriteString
	call CrLf
	mov edx,	[ebp+20]	; input request
	call    WriteString
	mov edx,	[ebp+16]	; The numbers should....
	call    WriteString
	mov edx,	[ebp+12]	; Once you have...
	call    WriteString
	mov edx,	[ebp+8]		; ; Next you will...
	call    WriteString			
	call CrLf
	pop	edx	; restore registers and return to clear the stack
	pop	ebp	
	ret	24
introduction ENDP





farewell	PROC
; Thank the user and bid them farewell
	push	ebp	; set up stack frame
	mov		ebp,esp
	push	edx	; save the edx register
	mov edx,	[ebp+8]	; Thanks for...
	call	WriteString
	call	CrLf
	pop	edx	; restore registers and return to clear the stack
	pop	ebp	
	ret	8
farewell	ENDP

END main
