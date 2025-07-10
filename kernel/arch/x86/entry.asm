global _start
section .text
bits 32
_start:
    mov dword [0xb8000], 0x0f4b0f4f
    hlt
    jmp $

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