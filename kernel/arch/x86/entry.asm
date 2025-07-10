global _start
section .text
bits 32
_start:
    mov eax, termLine
    mov dword [eax], 0xb8000
    mov edi, bootMsg
    call print
    mov edi, bootMsg2
    call print
    hlt
    jmp $

print:
    mov ebx, [termLine]
    .printLoop:
        mov eax, 0x0a00
        mov al, [edi]
        cmp al, 0
        je .endLoop

        mov word [ebx], ax

        add ebx, 2
        inc edi 
        jmp .printLoop
    .endLoop:
        mov eax, termLine
        add dword [eax], 80*2 ; new line
        ret

section .data
bootMsg db "booted into _start",0
bootMsg2 db "tryna boot into x86_64 long mode", 0

section .bss
termLine:
    resd 1

section .multiboot2
headerStart:
    dd 0xe85250d6
    dd 0
    dd headerStart - headerEnd
    dd 0x100000000 - (0xe85250d6 + 0 + (headerStart - headerEnd))

    ; no tag
    dw 0
    dw 0
    dd 8

headerEnd: