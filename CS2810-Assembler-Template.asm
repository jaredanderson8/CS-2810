TITLE CS2810 Assembler Template

; Student Name: Jared Anderson
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS2810 Spring Semester 2018",0
	vAssignment byte "Assembler Assignment #1",0
	vName byte "Jared Anderson",0

.code
main PROC
	;--------- Enter Code Below Here
	call clrscr

	mov dh, 2 ; dh = 2
	mov dl, 12
	call gotoxy

	mov edx, offset vSemester
	call WriteString


	mov dh, 3 
	mov dl, 12
	call gotoxy

	mov edx, offset vAssignment
	call WriteString


	mov dh, 4 
	mov dl, 12
	call gotoxy

	mov edx, offset vName
	call WriteString

	xor ecx, ecx
	call readChar

	exit
main ENDP

END main