extern printf
extern strcmp
extern malloc
extern strcpy

struc _employee
    _e_name:  resb 32
    _e_age:   resb 1
endstruc

section .data
    samuel       dq  0
    samuel_name  db  "Samuel", 0
    samuel_age   db  32
    sally        dq  0
    sally_name   db  "Sally", 0
    sally_age    db  28
    susan        dq  0
    susan_name   db  "Susan", 0
    susan_age    db  45
;     susan:
;         istruc _employee
;             at _e_name, db  "Susan", 0
;             at _e_age,  db  45
;         iend
    fmt_str  db  "%s", 10, 0
    fmt_int  db  "%d", 10, 0

section .text

global main
main:
    push rbp
    mov  rbp, rsp

    xor  rdi, rdi      ; rdi must be initialized!
    mov  rdi, _e_name
    add  rdi, _e_age
    call malloc
    mov  [samuel], rax
    xor  rdi, rdi
    mov  rdi, [samuel]
    add  rdi, _e_name
    lea  rsi, [samuel_name]
    call strcpy
    add  rdi, _e_age
    mov  rsi, [samuel_age]
    mov  [rdi], rsi
    xor  rdi, rdi
    xor  rsi, rsi

;     mov  rdi, _e_name
;     add  rdi, _e_age
;     call malloc
;     mov  [sally], rax
;     xor  rdi, rdi
;     lea  rdi, [sally+_e_name]
;     lea  rsi, [sally_name]
;     call strcpy
; 
;     mov  rdi, _e_name
;     add  rdi, _e_age
;     call malloc
;     mov  [susan], rax
;     xor  rdi, rdi
;     lea  rdi, [susan+_e_name]
;     lea  rsi, [susan_name]
;     call strcpy

    mov  rdi, fmt_str
    mov  rsi, [samuel]
    add  rsi, _e_name
    call printf
    mov  rdi, fmt_int
    mov  rsi, [samuel]
    add  rsi, _e_name
    add  rsi, _e_age
    mov  rsi, [rsi]
    call printf

;     lea  rdi, [sally]
;     lea  rsi, [samuel]
;     call compare_employee
; 
;     mov  rdi, fmt_int
;     mov  rsi, rax
;     call printf

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
  
