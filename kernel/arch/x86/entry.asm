global _start
section .text
bits 32
_start:
    call setUpGDT32
    mov eax, termLine
    mov dword [eax], 0xb8000
    mov edi, bootMsg2
    call print
    call initIDT32
    call checkLongMode
    mov eax, 0
    div eax
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

printAndHang:
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
        hlt
        jmp $

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
initIDTMsg db "Init IDT32 done!", 0

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


section .text
%macro initIDT32sub 1
    mov eax, IDT32M%1
    mov ebx, IDT32Entry%1.lowOffset
    mov word [ebx], ax
    shr eax, 16
    mov ebx, IDT32Entry%1.highOffset
    mov word [ebx], ax
%endmacro
initIDT32:
   initIDT32sub 0
   initIDT32sub 1
   initIDT32sub 2
   initIDT32sub 3
   initIDT32sub 4
   initIDT32sub 5
   initIDT32sub 6
   initIDT32sub 7
   initIDT32sub 8
   initIDT32sub 9
   initIDT32sub 10
   initIDT32sub 11
   initIDT32sub 12
   initIDT32sub 13
   initIDT32sub 14
   initIDT32sub 15
   initIDT32sub 16
   initIDT32sub 17
   initIDT32sub 18
   initIDT32sub 19
   initIDT32sub 20
   initIDT32sub 21
   initIDT32sub 22
   initIDT32sub 23
   initIDT32sub 24
   initIDT32sub 25
   initIDT32sub 26
   initIDT32sub 27
   initIDT32sub 28
   initIDT32sub 29
   initIDT32sub 30
   initIDT32sub 31
   initIDT32sub 32
   initIDT32sub 33
   initIDT32sub 34
   initIDT32sub 35
   initIDT32sub 36
   initIDT32sub 37
   initIDT32sub 38
   initIDT32sub 39
   initIDT32sub 40
   initIDT32sub 41
   initIDT32sub 42
   initIDT32sub 43
   initIDT32sub 44
   initIDT32sub 45
   initIDT32sub 46
   initIDT32sub 47
   initIDT32sub 48
   initIDT32sub 49
   initIDT32sub 50
   initIDT32sub 51
   initIDT32sub 52
   initIDT32sub 53
   initIDT32sub 54
   initIDT32sub 55
   initIDT32sub 56
   initIDT32sub 57
   initIDT32sub 58
   initIDT32sub 59
   initIDT32sub 60
   initIDT32sub 61
   initIDT32sub 62
   initIDT32sub 63
   initIDT32sub 64
   initIDT32sub 65
   initIDT32sub 66
   initIDT32sub 67
   initIDT32sub 68
   initIDT32sub 69
   initIDT32sub 70
   initIDT32sub 71
   initIDT32sub 72
   initIDT32sub 73
   initIDT32sub 74
   initIDT32sub 75
   initIDT32sub 76
   initIDT32sub 77
   initIDT32sub 78
   initIDT32sub 79
   initIDT32sub 80
   initIDT32sub 81
   initIDT32sub 82
   initIDT32sub 83
   initIDT32sub 84
   initIDT32sub 85
   initIDT32sub 86
   initIDT32sub 87
   initIDT32sub 88
   initIDT32sub 89
   initIDT32sub 90
   initIDT32sub 91
   initIDT32sub 92
   initIDT32sub 93
   initIDT32sub 94
   initIDT32sub 95
   initIDT32sub 96
   initIDT32sub 97
   initIDT32sub 98
   initIDT32sub 99
   initIDT32sub 100
   initIDT32sub 101
   initIDT32sub 102
   initIDT32sub 103
   initIDT32sub 104
   initIDT32sub 105
   initIDT32sub 106
   initIDT32sub 107
   initIDT32sub 108
   initIDT32sub 109
   initIDT32sub 110
   initIDT32sub 111
   initIDT32sub 112
   initIDT32sub 113
   initIDT32sub 114
   initIDT32sub 115
   initIDT32sub 116
   initIDT32sub 117
   initIDT32sub 118
   initIDT32sub 119
   initIDT32sub 120
   initIDT32sub 121
   initIDT32sub 122
   initIDT32sub 123
   initIDT32sub 124
   initIDT32sub 125
   initIDT32sub 126
   initIDT32sub 127
   initIDT32sub 128
   initIDT32sub 129
   initIDT32sub 130
   initIDT32sub 131
   initIDT32sub 132
   initIDT32sub 133
   initIDT32sub 134
   initIDT32sub 135
   initIDT32sub 136
   initIDT32sub 137
   initIDT32sub 138
   initIDT32sub 139
   initIDT32sub 140
   initIDT32sub 141
   initIDT32sub 142
   initIDT32sub 143
   initIDT32sub 144
   initIDT32sub 145
   initIDT32sub 146
   initIDT32sub 147
   initIDT32sub 148
   initIDT32sub 149
   initIDT32sub 150
   initIDT32sub 151
   initIDT32sub 152
   initIDT32sub 153
   initIDT32sub 154
   initIDT32sub 155
   initIDT32sub 156
   initIDT32sub 157
   initIDT32sub 158
   initIDT32sub 159
   initIDT32sub 160
   initIDT32sub 161
   initIDT32sub 162
   initIDT32sub 163
   initIDT32sub 164
   initIDT32sub 165
   initIDT32sub 166
   initIDT32sub 167
   initIDT32sub 168
   initIDT32sub 169
   initIDT32sub 170
   initIDT32sub 171
   initIDT32sub 172
   initIDT32sub 173
   initIDT32sub 174
   initIDT32sub 175
   initIDT32sub 176
   initIDT32sub 177
   initIDT32sub 178
   initIDT32sub 179
   initIDT32sub 180
   initIDT32sub 181
   initIDT32sub 182
   initIDT32sub 183
   initIDT32sub 184
   initIDT32sub 185
   initIDT32sub 186
   initIDT32sub 187
   initIDT32sub 188
   initIDT32sub 189
   initIDT32sub 190
   initIDT32sub 191
   initIDT32sub 192
   initIDT32sub 193
   initIDT32sub 194
   initIDT32sub 195
   initIDT32sub 196
   initIDT32sub 197
   initIDT32sub 198
   initIDT32sub 199
   initIDT32sub 200
   initIDT32sub 201
   initIDT32sub 202
   initIDT32sub 203
   initIDT32sub 204
   initIDT32sub 205
   initIDT32sub 206
   initIDT32sub 207
   initIDT32sub 208
   initIDT32sub 209
   initIDT32sub 210
   initIDT32sub 211
   initIDT32sub 212
   initIDT32sub 213
   initIDT32sub 214
   initIDT32sub 215
   initIDT32sub 216
   initIDT32sub 217
   initIDT32sub 218
   initIDT32sub 219
   initIDT32sub 220
   initIDT32sub 221
   initIDT32sub 222
   initIDT32sub 223
   initIDT32sub 224
   initIDT32sub 225
   initIDT32sub 226
   initIDT32sub 227
   initIDT32sub 228
   initIDT32sub 229
   initIDT32sub 230
   initIDT32sub 231
   initIDT32sub 232
   initIDT32sub 233
   initIDT32sub 234
   initIDT32sub 235
   initIDT32sub 236
   initIDT32sub 237
   initIDT32sub 238
   initIDT32sub 239
   initIDT32sub 240
   initIDT32sub 241
   initIDT32sub 242
   initIDT32sub 243
   initIDT32sub 244
   initIDT32sub 245
   initIDT32sub 246
   initIDT32sub 247
   initIDT32sub 248
   initIDT32sub 249
   initIDT32sub 250
   initIDT32sub 251
   initIDT32sub 252
   initIDT32sub 253
   initIDT32sub 254
   initIDT32sub 255
    lidt [IDT32R]
    mov edi, initIDTMsg
    call print
    ret

section .data

;TODO
IDT32R:
    dw IDT32EntriesBegin - IDT32EntriesEnd
    dd IDT32EntriesBegin

%macro IDT32Middleware 1
section .text
IDT32MA%1 equ $
IDT32M%1:
    mov edi, msgTG%1
    jmp printAndHang
section .data
msgTG%1 db "Error number "
db %str(%1)
db ", hang now!", 0
%endmacro

%macro IDT32Entry 1
section .data
IDT32Entry%1:
    .lowOffset:
    dw 0                               ; low offset
    dw GDT32.CODE - GDT32              ; CS
    db 0                               ; Reserved
    db 0b10001111                      ; some flags
    .highOffset:
    dw 0                               ; high offset
%endmacro

IDT32Middleware 0
IDT32Middleware 1
IDT32Middleware 2
IDT32Middleware 3
IDT32Middleware 4
IDT32Middleware 5
IDT32Middleware 6
IDT32Middleware 7
IDT32Middleware 8
IDT32Middleware 9
IDT32Middleware 10
IDT32Middleware 11
IDT32Middleware 12
IDT32Middleware 13
IDT32Middleware 14
IDT32Middleware 15
IDT32Middleware 16
IDT32Middleware 17
IDT32Middleware 18
IDT32Middleware 19
IDT32Middleware 20
IDT32Middleware 21
IDT32Middleware 22
IDT32Middleware 23
IDT32Middleware 24
IDT32Middleware 25
IDT32Middleware 26
IDT32Middleware 27
IDT32Middleware 28
IDT32Middleware 29
IDT32Middleware 30
IDT32Middleware 31
IDT32Middleware 32
IDT32Middleware 33
IDT32Middleware 34
IDT32Middleware 35
IDT32Middleware 36
IDT32Middleware 37
IDT32Middleware 38
IDT32Middleware 39
IDT32Middleware 40
IDT32Middleware 41
IDT32Middleware 42
IDT32Middleware 43
IDT32Middleware 44
IDT32Middleware 45
IDT32Middleware 46
IDT32Middleware 47
IDT32Middleware 48
IDT32Middleware 49
IDT32Middleware 50
IDT32Middleware 51
IDT32Middleware 52
IDT32Middleware 53
IDT32Middleware 54
IDT32Middleware 55
IDT32Middleware 56
IDT32Middleware 57
IDT32Middleware 58
IDT32Middleware 59
IDT32Middleware 60
IDT32Middleware 61
IDT32Middleware 62
IDT32Middleware 63
IDT32Middleware 64
IDT32Middleware 65
IDT32Middleware 66
IDT32Middleware 67
IDT32Middleware 68
IDT32Middleware 69
IDT32Middleware 70
IDT32Middleware 71
IDT32Middleware 72
IDT32Middleware 73
IDT32Middleware 74
IDT32Middleware 75
IDT32Middleware 76
IDT32Middleware 77
IDT32Middleware 78
IDT32Middleware 79
IDT32Middleware 80
IDT32Middleware 81
IDT32Middleware 82
IDT32Middleware 83
IDT32Middleware 84
IDT32Middleware 85
IDT32Middleware 86
IDT32Middleware 87
IDT32Middleware 88
IDT32Middleware 89
IDT32Middleware 90
IDT32Middleware 91
IDT32Middleware 92
IDT32Middleware 93
IDT32Middleware 94
IDT32Middleware 95
IDT32Middleware 96
IDT32Middleware 97
IDT32Middleware 98
IDT32Middleware 99
IDT32Middleware 100
IDT32Middleware 101
IDT32Middleware 102
IDT32Middleware 103
IDT32Middleware 104
IDT32Middleware 105
IDT32Middleware 106
IDT32Middleware 107
IDT32Middleware 108
IDT32Middleware 109
IDT32Middleware 110
IDT32Middleware 111
IDT32Middleware 112
IDT32Middleware 113
IDT32Middleware 114
IDT32Middleware 115
IDT32Middleware 116
IDT32Middleware 117
IDT32Middleware 118
IDT32Middleware 119
IDT32Middleware 120
IDT32Middleware 121
IDT32Middleware 122
IDT32Middleware 123
IDT32Middleware 124
IDT32Middleware 125
IDT32Middleware 126
IDT32Middleware 127
IDT32Middleware 128
IDT32Middleware 129
IDT32Middleware 130
IDT32Middleware 131
IDT32Middleware 132
IDT32Middleware 133
IDT32Middleware 134
IDT32Middleware 135
IDT32Middleware 136
IDT32Middleware 137
IDT32Middleware 138
IDT32Middleware 139
IDT32Middleware 140
IDT32Middleware 141
IDT32Middleware 142
IDT32Middleware 143
IDT32Middleware 144
IDT32Middleware 145
IDT32Middleware 146
IDT32Middleware 147
IDT32Middleware 148
IDT32Middleware 149
IDT32Middleware 150
IDT32Middleware 151
IDT32Middleware 152
IDT32Middleware 153
IDT32Middleware 154
IDT32Middleware 155
IDT32Middleware 156
IDT32Middleware 157
IDT32Middleware 158
IDT32Middleware 159
IDT32Middleware 160
IDT32Middleware 161
IDT32Middleware 162
IDT32Middleware 163
IDT32Middleware 164
IDT32Middleware 165
IDT32Middleware 166
IDT32Middleware 167
IDT32Middleware 168
IDT32Middleware 169
IDT32Middleware 170
IDT32Middleware 171
IDT32Middleware 172
IDT32Middleware 173
IDT32Middleware 174
IDT32Middleware 175
IDT32Middleware 176
IDT32Middleware 177
IDT32Middleware 178
IDT32Middleware 179
IDT32Middleware 180
IDT32Middleware 181
IDT32Middleware 182
IDT32Middleware 183
IDT32Middleware 184
IDT32Middleware 185
IDT32Middleware 186
IDT32Middleware 187
IDT32Middleware 188
IDT32Middleware 189
IDT32Middleware 190
IDT32Middleware 191
IDT32Middleware 192
IDT32Middleware 193
IDT32Middleware 194
IDT32Middleware 195
IDT32Middleware 196
IDT32Middleware 197
IDT32Middleware 198
IDT32Middleware 199
IDT32Middleware 200
IDT32Middleware 201
IDT32Middleware 202
IDT32Middleware 203
IDT32Middleware 204
IDT32Middleware 205
IDT32Middleware 206
IDT32Middleware 207
IDT32Middleware 208
IDT32Middleware 209
IDT32Middleware 210
IDT32Middleware 211
IDT32Middleware 212
IDT32Middleware 213
IDT32Middleware 214
IDT32Middleware 215
IDT32Middleware 216
IDT32Middleware 217
IDT32Middleware 218
IDT32Middleware 219
IDT32Middleware 220
IDT32Middleware 221
IDT32Middleware 222
IDT32Middleware 223
IDT32Middleware 224
IDT32Middleware 225
IDT32Middleware 226
IDT32Middleware 227
IDT32Middleware 228
IDT32Middleware 229
IDT32Middleware 230
IDT32Middleware 231
IDT32Middleware 232
IDT32Middleware 233
IDT32Middleware 234
IDT32Middleware 235
IDT32Middleware 236
IDT32Middleware 237
IDT32Middleware 238
IDT32Middleware 239
IDT32Middleware 240
IDT32Middleware 241
IDT32Middleware 242
IDT32Middleware 243
IDT32Middleware 244
IDT32Middleware 245
IDT32Middleware 246
IDT32Middleware 247
IDT32Middleware 248
IDT32Middleware 249
IDT32Middleware 250
IDT32Middleware 251
IDT32Middleware 252
IDT32Middleware 253
IDT32Middleware 254
IDT32Middleware 255

section .data
IDT32EntriesBegin:
IDT32Entry 0
IDT32Entry 1
IDT32Entry 2
IDT32Entry 3
IDT32Entry 4
IDT32Entry 5
IDT32Entry 6
IDT32Entry 7
IDT32Entry 8
IDT32Entry 9
IDT32Entry 10
IDT32Entry 11
IDT32Entry 12
IDT32Entry 13
IDT32Entry 14
IDT32Entry 15
IDT32Entry 16
IDT32Entry 17
IDT32Entry 18
IDT32Entry 19
IDT32Entry 20
IDT32Entry 21
IDT32Entry 22
IDT32Entry 23
IDT32Entry 24
IDT32Entry 25
IDT32Entry 26
IDT32Entry 27
IDT32Entry 28
IDT32Entry 29
IDT32Entry 30
IDT32Entry 31
IDT32Entry 32
IDT32Entry 33
IDT32Entry 34
IDT32Entry 35
IDT32Entry 36
IDT32Entry 37
IDT32Entry 38
IDT32Entry 39
IDT32Entry 40
IDT32Entry 41
IDT32Entry 42
IDT32Entry 43
IDT32Entry 44
IDT32Entry 45
IDT32Entry 46
IDT32Entry 47
IDT32Entry 48
IDT32Entry 49
IDT32Entry 50
IDT32Entry 51
IDT32Entry 52
IDT32Entry 53
IDT32Entry 54
IDT32Entry 55
IDT32Entry 56
IDT32Entry 57
IDT32Entry 58
IDT32Entry 59
IDT32Entry 60
IDT32Entry 61
IDT32Entry 62
IDT32Entry 63
IDT32Entry 64
IDT32Entry 65
IDT32Entry 66
IDT32Entry 67
IDT32Entry 68
IDT32Entry 69
IDT32Entry 70
IDT32Entry 71
IDT32Entry 72
IDT32Entry 73
IDT32Entry 74
IDT32Entry 75
IDT32Entry 76
IDT32Entry 77
IDT32Entry 78
IDT32Entry 79
IDT32Entry 80
IDT32Entry 81
IDT32Entry 82
IDT32Entry 83
IDT32Entry 84
IDT32Entry 85
IDT32Entry 86
IDT32Entry 87
IDT32Entry 88
IDT32Entry 89
IDT32Entry 90
IDT32Entry 91
IDT32Entry 92
IDT32Entry 93
IDT32Entry 94
IDT32Entry 95
IDT32Entry 96
IDT32Entry 97
IDT32Entry 98
IDT32Entry 99
IDT32Entry 100
IDT32Entry 101
IDT32Entry 102
IDT32Entry 103
IDT32Entry 104
IDT32Entry 105
IDT32Entry 106
IDT32Entry 107
IDT32Entry 108
IDT32Entry 109
IDT32Entry 110
IDT32Entry 111
IDT32Entry 112
IDT32Entry 113
IDT32Entry 114
IDT32Entry 115
IDT32Entry 116
IDT32Entry 117
IDT32Entry 118
IDT32Entry 119
IDT32Entry 120
IDT32Entry 121
IDT32Entry 122
IDT32Entry 123
IDT32Entry 124
IDT32Entry 125
IDT32Entry 126
IDT32Entry 127
IDT32Entry 128
IDT32Entry 129
IDT32Entry 130
IDT32Entry 131
IDT32Entry 132
IDT32Entry 133
IDT32Entry 134
IDT32Entry 135
IDT32Entry 136
IDT32Entry 137
IDT32Entry 138
IDT32Entry 139
IDT32Entry 140
IDT32Entry 141
IDT32Entry 142
IDT32Entry 143
IDT32Entry 144
IDT32Entry 145
IDT32Entry 146
IDT32Entry 147
IDT32Entry 148
IDT32Entry 149
IDT32Entry 150
IDT32Entry 151
IDT32Entry 152
IDT32Entry 153
IDT32Entry 154
IDT32Entry 155
IDT32Entry 156
IDT32Entry 157
IDT32Entry 158
IDT32Entry 159
IDT32Entry 160
IDT32Entry 161
IDT32Entry 162
IDT32Entry 163
IDT32Entry 164
IDT32Entry 165
IDT32Entry 166
IDT32Entry 167
IDT32Entry 168
IDT32Entry 169
IDT32Entry 170
IDT32Entry 171
IDT32Entry 172
IDT32Entry 173
IDT32Entry 174
IDT32Entry 175
IDT32Entry 176
IDT32Entry 177
IDT32Entry 178
IDT32Entry 179
IDT32Entry 180
IDT32Entry 181
IDT32Entry 182
IDT32Entry 183
IDT32Entry 184
IDT32Entry 185
IDT32Entry 186
IDT32Entry 187
IDT32Entry 188
IDT32Entry 189
IDT32Entry 190
IDT32Entry 191
IDT32Entry 192
IDT32Entry 193
IDT32Entry 194
IDT32Entry 195
IDT32Entry 196
IDT32Entry 197
IDT32Entry 198
IDT32Entry 199
IDT32Entry 200
IDT32Entry 201
IDT32Entry 202
IDT32Entry 203
IDT32Entry 204
IDT32Entry 205
IDT32Entry 206
IDT32Entry 207
IDT32Entry 208
IDT32Entry 209
IDT32Entry 210
IDT32Entry 211
IDT32Entry 212
IDT32Entry 213
IDT32Entry 214
IDT32Entry 215
IDT32Entry 216
IDT32Entry 217
IDT32Entry 218
IDT32Entry 219
IDT32Entry 220
IDT32Entry 221
IDT32Entry 222
IDT32Entry 223
IDT32Entry 224
IDT32Entry 225
IDT32Entry 226
IDT32Entry 227
IDT32Entry 228
IDT32Entry 229
IDT32Entry 230
IDT32Entry 231
IDT32Entry 232
IDT32Entry 233
IDT32Entry 234
IDT32Entry 235
IDT32Entry 236
IDT32Entry 237
IDT32Entry 238
IDT32Entry 239
IDT32Entry 240
IDT32Entry 241
IDT32Entry 242
IDT32Entry 243
IDT32Entry 244
IDT32Entry 245
IDT32Entry 246
IDT32Entry 247
IDT32Entry 248
IDT32Entry 249
IDT32Entry 250
IDT32Entry 251
IDT32Entry 252
IDT32Entry 253
IDT32Entry 254
IDT32Entry 255
IDT32EntriesEnd:


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