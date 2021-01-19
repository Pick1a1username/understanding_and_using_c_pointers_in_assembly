extern printf

struc mytype
    mt_long:  resd 1
    mt_word:  resw 1
    mt_byte:  resb 1
    mt_str:   resb 32
endstruc

section .data
    mystruc:
        istruc mytype
            at mt_long, dd    123456
            at mt_word, dw    1024
            at mt_byte, db    "x"
            at mt_str,  db    "hello, world", 13, 10, 0
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
