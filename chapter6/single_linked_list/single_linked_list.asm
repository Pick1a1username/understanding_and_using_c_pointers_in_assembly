extern printf

struc _employee
    _e_name:  resb 32
    _e_age:   resb 1
endstruc

section .data
    samuel:
        istruc _employee
            at _e_name, db  "Samuel"
            at _e_age,  db  32
        iend
    fmt_str  db  "%s", 10

section .text
    global main
main:
    push rbp
    mov  rbp, rsp

    mov  rdi, fmt_str
    lea  rsi, [samuel+_e_name]
    call printf

    leave
    ret
