TITLE CS2810 Assembler Template

; Student Name: Jared Anderson
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS2810 Spring Semester 2017",0
	vAssignment byte "Assembler Assignment #2",0
	vName byte "Jared Anderson",0
	vPrompt byte "Please enter in a MP3 frame header in hex format: ",0

	vMpeg25 byte "MPEG Version 2.5",0
	vMpeg20 byte "MPEG Version 2.0",0
	vMpeg10 byte "MPEG Version 1.0",0
	vMpegRE byte "MPEG Reserved",0

	vLayerRE byte "Layer Reserved",0
	vLayeriii byte "Layer III",0
	vLayerii byte "Layer II",0
	vLayeri byte "Layer I",0

	v44100 byte "Sample Rate: 44100Hz",0
	v48000 byte "Sample Rate: 48000Hz",0
	v32000 byte "Sample Rate: 32000Hz",0

	v22050 byte "Sample Rate: 22050Hz",0
	v24000 byte "Sample Rate: 24000Hz",0
	v16000 byte "Sample Rate: 16000Hz",0

	v11025 byte "Sample Rate: 11025Hz",0
	v12000 byte "Sample Rate: 12000Hz",0
	v8000 byte "Sample Rate: 8000Hz",0

	vreserv byte "Sample Rate: reserv.",0


.code
main PROC
	;--------- Enter Code Below Here

call clrscr

	call DisplaySemester
	call DisplayAssignment
	call DisplayName
	call DisplayPrompt
	call ReadMP3Header
	call DisplayVersion
	call DisplayLayerDescription
	call DisplaySamplingRate

DisplaySemester:

	mov dh, 10
	mov dl, 12
	call gotoxy

	mov edx, offset vSemester
	call WriteString

	ret

DisplayAssignment:

	mov dh, 11 
	mov dl, 12
	call gotoxy

	mov edx, offset vAssignment
	call WriteString

	ret

DisplayName:

	mov dh, 12 
	mov dl, 12
	call gotoxy

	mov edx, offset vName
	call WriteString

	ret

DisplayPrompt:

	mov dh, 13
	mov dl, 12
	call gotoxy

	mov edx, offset vPrompt
	call WriteString

	ret

ReadMP3Header:
	mov dh, 14
	mov dl, 12
	call gotoxy

	call ReadHex

	mov ecx, eax

	ret

DisplayVersion:

	mov dh, 16
	mov dl, 12
	call gotoxy

	mov eax, ecx ;0FFFB9264h
			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	and eax, 00000000000110000000000000000000b
	shr eax, 19

	cmp eax, 00b
	jz dMpeg25

	cmp eax, 01b
	jz dMpegRE

	cmp eax, 10b
	jz dMpeg20

	mov edx, offset vMpeg10
	jmp DisplayString

	ret

dMpeg25:
	mov edx, offset vMpeg25
	jmp DisplayString

dMpegRE:
	mov edx, offset vMpegRE
	jmp DisplayString

dMpeg20:
	mov edx, offset vMpeg20
	jmp DisplayString



DisplayLayerDescription:

	mov dh, 17
	mov dl, 12
	call gotoxy

	mov eax, ecx

			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	and eax, 00000000000001100000000000000000b
	shr eax, 17

	cmp eax, 00b
	jz dLayerRE

	cmp eax, 01b
	jz dLayeriii

	cmp eax, 10b
	jz dLayerii

	mov edx, offset vLayeri
	jmp DisplayString

	ret

dLayerRE:
	mov edx, offset vLayerRE
	jmp DisplayString

dLayeriii:
	mov edx, offset vLayeriii
	jmp DisplayString

dLayerii:
	mov edx, offset vLayerii
	jmp DisplayString

DisplayString:
	call WriteString
	ret


DisplaySamplingRate:
	mov dh, 18
	mov dl, 12
	call gotoxy

	mov eax, ecx

			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	and eax, 00000000000000000000110000000000b
	shr eax, 10

			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	and ecx, 00000000000110000000000000000000b
	shr ecx, 19

	cmp ecx, 00b
	jz dM25

	cmp ecx, 01b
	jz dMRE

	cmp ecx, 10b
	jz dM2

	jmp dM1

	ret

dM1:
	cmp eax, 00b
	jz d44100

	cmp eax, 01b
	jz d48000

	cmp eax, 10b
	jz d32000

	mov edx, offset vreserv
	jmp DisplayString

	ret

dM2:
	cmp eax, 00b
	jz d22050

	cmp eax, 01b
	jz d24000

	cmp eax, 10b
	jz d16000

	mov edx, offset vreserv
	jmp DisplayString

	ret

dM25:
	cmp eax, 00b
	jz d11025

	cmp eax, 01b
	jz d12000

	cmp eax, 10b
	jz d8000

	mov edx, offset vreserv
	jmp DisplayString

	ret

dMRE:
	mov edx, offset vreserv
	jmp DisplayString

	ret


d44100:
	mov edx, offset v44100
	jmp DisplayString

d48000:
	mov edx, offset v48000
	jmp DisplayString

d32000:
	mov edx, offset v32000
	jmp DisplayString


d22050:
	mov edx, offset v22050
	jmp DisplayString

d24000:
	mov edx, offset v24000
	jmp DisplayString

d16000:
	mov edx, offset v16000
	jmp DisplayString

	
d11025:
	mov edx, offset v11025
	jmp DisplayString

d12000:
	mov edx, offset v12000
	jmp DisplayString

d8000:
	mov edx, offset v8000
	jmp DisplayString


call ReadChar
main ENDP

END main