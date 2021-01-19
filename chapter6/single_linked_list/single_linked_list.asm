extern printf

struc _employee
    .long:  resd 1
    .word:  resw 1
    .byte:  resb 32
    .str:   resb 32
endstruc

section .data
    mystruc:
        istruc mytype
            at .long, dd    123456
            at .word, dw    1024
            at .byte, db    "x"
            at .str,  db    "hello, world", 13, 10, 0
        iend
    fmt_str  db  "%s"

section .text
    global main
main:
    push rbp
    mov  rbp, rsp

    mov  rdi, fmt_str
    lea  rsi, [mystruc+mt_str]
    call printf

    leave
    ret
