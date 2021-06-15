TITLE CS2810 Assembler Template

; Student Name: Jared Anderson
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS2810 Spring Semester 2018",0
	vAssignment byte "Assembler Assignment #1",0
	vName byte "Jared Anderson",0
	vTimeField byte "--:--:--",0
	vPrompt byte "Please enter in a FAT16 file time: "

.code
main PROC
	;--------- Enter Code Below Here
	call clrscr

	mov dh, 15 
	mov dl, 20
	call gotoxy

	mov edx, offset vSemester
	call WriteString


	mov dh, 16 
	mov dl, 20
	call gotoxy

	mov edx, offset vAssignment
	call WriteString

	
	mov dh, 17 
	mov dl, 20
	call gotoxy

	mov edx, offset vName
	call WriteString

	mov dh, 18 
	mov dl, 20
	call gotoxy

	mov edx, offset vPrompt
	call WriteString
	
	mov dh, 19 
	mov dl, 20
	call gotoxy

	call ReadHex
	ror ax,8

	mov ecx, eax

	and ax, 1111100000000000b
	shr ax, 11
	mov bh, 10
	div bh
	add ax, 3030h

	mov word ptr [vTimeField+0], ax

	mov eax, ecx

	and ax, 0000011111100000b
    shr ax, 5
    mov bh, 10
    div bh
    add ax, 3030h

	mov word ptr [vTimeField+3], ax

	mov eax, ecx

	and ax, 0000000000011111b
    shl ax, 1
    mov bh, 10
    div bh
    add ax, 3030h

	mov word ptr [vTimeField+6], ax

	mov dh, 20 
	mov dl, 20
	call gotoxy

	mov EDX, OFFSET vTImeField
	call WriteString

	xor ecx, ecx
	call readChar

	exit

main ENDP

END main