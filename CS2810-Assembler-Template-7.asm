TITLE CS2810 Assembler Template

; Student Name:
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS 2810 Fall Semester 2017",0
	vAssignment byte "Assembler #5",0
	vName byte "Jared Anderson",0

	vPrompt byte "Guess a number between 0 and 100: ",0
	vGuess byte "Guess again: ",0
	vHigh byte "--- is too high",0
	vLow byte "--- is too low",0
	vCorrect byte "--- is correct!",0
	vAgain byte "Would you like to play again? (1 for yes, 0 for no): ",0

	vYPos DB 7
	vXPos DB 0


.code
main PROC
	;--------- Enter Code Below Here

	call clrscr

	call DisplaySemester
	call DisplayAssignment
	call DisplayName

	MainLoop:

		call MoveToNextLine

		call Randomize
		mov eax, 101
		call RandomRange

		mov ecx, eax

		mov edx, offset vPrompt

		GameLoop:
			call WriteString
			call ReadDec

			call MoveToNextLine

			cmp eax, ecx

			jg DisplayTooHigh

			jl DisplayTooLow

			jz DisplayCorrect

		EndGameLoop:

		call MoveToNextLine

		mov edx, offset vAgain
		call WriteString
		call ReadDec

	call MoveToNextLine
	cmp eax, 1
	jz MainLoop


	call EndProg



DisplaySemester:

	mov dh, 4
	mov dl, 0
	call gotoxy

	mov edx, offset vSemester
	call WriteString

	ret

DisplayAssignment:

	mov dh, 5 
	mov dl, 0
	call gotoxy

	mov edx, offset vAssignment
	call WriteString

	ret

DisplayName:

	mov dh, 6 
	mov dl, 0
	call gotoxy

	mov edx, offset vName
	call WriteString

	ret

MoveToNextLine:
	add vYPos, 1

	mov dh, vYPos
	mov dl, vXpos
	call gotoxy

	ret

DisplayTooHigh:

	xor dx, dx
	mov bx, 100
	div bx 
	add al, 30h
	mov word ptr [vHigh], ax

	mov ax, dx
	mov bl, 10
	div bl
	add ax, 3030h
	mov word ptr [vHigh+1], ax

	mov edx, offset vHigh
	call WriteString

	call MoveToNextLine
	mov edx, offset vGuess
	jmp GameLoop

DisplayTooLow:

	xor dx, dx
	mov bx, 100
	div bx 
	add al, 30h
	mov word ptr [vLow], ax

	mov ax, dx
	mov bl, 10
	div bl
	add ax, 3030h
	mov word ptr [vLow+1], ax

	mov edx, offset vLow
	call WriteString

	call MoveToNextLine
	mov edx, offset vGuess
	jmp GameLoop

DisplayCorrect:

	xor dx, dx
	mov bx, 100
	div bx 
	add al, 30h
	mov word ptr [vCorrect], ax

	mov ax, dx
	mov bl, 10
	div bl
	add ax, 3030h
	mov word ptr [vCorrect+1], ax

	mov edx, offset vCorrect
	call WriteString
	jmp EndGameLoop



EndProg:

	call ReadChar
	main ENDP

END main