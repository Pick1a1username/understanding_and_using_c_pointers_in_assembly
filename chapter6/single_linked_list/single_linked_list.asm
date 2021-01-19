extern printf
extern strcmp

struc _employee
    _e_name:  resb 32
    _e_age:   resb 1
endstruc

section .data
    samuel:
        istruc _employee
            at _e_name, db  "Samuel", 0
            at _e_age,  db  32
        iend
    sally:
        istruc _employee
            at _e_name, db  "Sally", 0
            at _e_age,  db  28
        iend
    susan:
        istruc _employee
            at _e_name, db  "Susan", 0
            at _e_age,  db  45
        iend
    fmt_str  db  "%s", 10, 0
    fmt_int  db  "%d", 10, 0

section .text

global main
main:
    push rbp
    mov  rbp, rsp

    mov  rdi, fmt_str
    lea  rsi, [samuel+_e_name]
    call printf

    lea  rdi, [sally]
    lea  rsi, [samuel]
    call compare_employee

    mov  rdi, fmt_int
    mov  rsi, rax
    call printf

    leave
    ret

global compare_employee
compare_employee:
    section .text 
        push rbp
        mov  rbp, rsp

        lea rdi, [rdi+_e_name]
        lea rsi, [rsi+_e_name]
        call strcmp

        leave
        ret
  
