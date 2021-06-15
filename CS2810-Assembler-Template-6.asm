TITLE CS2810 Assembler Template

; Student Name: Jared Anderson
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS2810 Summer Semester 2017",0
	vAssignment byte "Assembler Assignment #2",0
	vName byte "Jared Anderson",0
	vPrompt byte "Please enter in a FAT16 Date",0

	vYear byte "----",0
	vSpace byte " ",0

	vMonthArray BYTE "Incorrect1",0
		BYTE "January",0,"123"
		BYTE "Febuary",0,"123"
		BYTE "March",0,"12345"
		BYTE "April",0,"12345"
		BYTE "May",0,"1234567"
		BYTE "June",0,"123456"
		BYTE "July",0,"123456"
		BYTE "August",0,"1234"
		BYTE "September",0,"1"
		BYTE "October",0,"123"
		BYTE "November",0,"12"
		BYTE "December",0,"12"
		BYTE "Incorrect2",0
		BYTE "Incorrect3",0
		BYTE "Incorrect4",0

	vDayArray byte "error",0
		byte "1st,",0," "
		byte "2nd,",0," "
		byte "3rd,",0," "
		byte "4th,",0," "
		byte "5th,",0," "
		byte "6th,",0," "
		byte "7th,",0," "
		byte "8th,",0," "
		byte "9th,",0," "
		byte "10th,",0
		byte "11th,",0
		byte "12th,",0
		byte "13th,",0
		byte "14th,",0
		byte "15th,",0
		byte "16th,",0
		byte "17th,",0
		byte "18th,",0
		byte "19th,",0
		byte "20th,",0
		byte "21st,",0
		byte "22nd,",0
		byte "23rd,",0
		byte "24th,",0
		byte "25th,",0
		byte "26th,",0
		byte "27th,",0
		byte "28th,",0
		byte "29th,",0
		byte "30th,",0
		byte "31st,",0
		


.code
main PROC
	;--------- Enter Code Below Here

call clrscr

	call DisplaySemester
	call DisplayAssignment
	call DisplayName

	call DisplayPrompt
	call ReadFAT16Date

	call GetMonth
	call PrintSpace
	call GetDay
	call PrintSpace
	call GetYear

	call EndProg

DisplaySemester:

	mov dh, 4
	mov dl, 33
	call gotoxy

	mov edx, offset vSemester
	call WriteString

	ret

DisplayAssignment:

	mov dh, 5 
	mov dl, 33
	call gotoxy

	mov edx, offset vAssignment
	call WriteString

	ret

DisplayName:

	mov dh, 6 
	mov dl, 33
	call gotoxy

	mov edx, offset vName
	call WriteString

	ret

DisplayPrompt:

	mov dh, 8
	mov dl, 33
	call gotoxy

	mov edx, offset vPrompt
	call WriteString

	ret

ReadFAT16Date:

	mov dh, 9
	mov dl, 33
	call gotoxy

	call ReadHex

	ror ax,8

	mov ecx, eax

	ret

PrintSpace:
	mov edx, offset vSpace
	call WriteString

	ret


GetYear:

	mov eax, ecx
			;YYYYYYYMMMMDDDDD
	and eax, 1111111000000000b
	shr eax, 9

	add eax, 7BCh

	xor dx, dx
	mov bx, 1000
	div bx 
	add al, 30h
	mov byte ptr [vYear], al

	mov ax, dx
	xor dx,dx
	mov bx, 100
	div bx
	add al, 30h
	mov byte ptr [vYear+1], al

	mov ax, dx
	mov bl, 10
	div bl
	add ax, 3030h
	mov word ptr [vYear+2], ax
	mov edx, offset [vYear]

	mov edx, offset vYear
	call WriteString

	ret

GetMonth:

	mov dh, 10
	mov dl, 33
	call gotoxy

	mov eax, ecx
			;YYYYYYYMMMMDDDDD
	and eax, 0000000111100000b
	shr eax, 5
	
	mov edx, offset [vMonthArray]
	mov bl, 11
	mul bl

	add edx, eax
	call WriteString

	ret

GetDay:
	mov eax, ecx
			;YYYYYYYMMMMDDDDD
	and eax, 0000000000011111b

	mov edx, offset [vDayArray]
	mov bl, 6
	mul bl

	add edx, eax
	call WriteString

	ret
	
EndProg:

	call ReadChar
	main ENDP

END main