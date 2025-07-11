global _start
section .text
bits 32
_start:
    call setUpGDT32
    mov eax, termLine
    mov dword [eax], 0xb8000
    mov edi, bootMsg2
    call print
    call checkLongMode
    hlt
    jmp $

setUpGDT32:
    lgdt [GDT32R]
    jmp (GDT32.CODE-GDT32):reloadCS
    ret

reloadCS:
    mov ax, GDT32.DATA-GDT32
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    ret

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

checkLongMode:
    mov eax, 0x80000000
    cpuid
    cmp eax, 0x80000001
    jb .noLongMode

    mov eax, 0x80000001
    cpuid
    test edx, 0x20000000
    jz .noLongMode

    mov edi, bootMsg3
    call print
    ret
    .noLongMode:
        mov edi, bootMsg
        call print
        hlt
        jmp $



section .data
bootMsg db "This device doesn't support long mode", 0
bootMsg2 db "Tryna boot into x86_64 long mode", 0
bootMsg3 db "Long mode check passed!", 0

GDT32R:
    dw GDT32End - GDT32
    dd GDT32

GDT32:
    .NULL:
        dq 0

    .CODE:
        dw 0xffff     ; low limit
        dw 0          ; low base
        db 0          ; mid base
        db 0x9a       ; access bit
        db 0b11001111 ; flags + high limit
        db 0          ; high base

    .DATA:
        dw 0xffff     ; low limit
        dw 0          ; low base
        db 0          ; mid base
        db 0x92       ; access bit
        db 0b11001111 ; flags + high limit
        db 0          ; high base
GDT32End:

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