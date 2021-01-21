%include "employee.asm"
%include "single_linked_list.asm"

extern printf
extern strcmp
extern malloc
extern strcpy

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
    fmt_str  db  "%s", 10, 0
    fmt_int  db  "%d", 10, 0

section .text

global main
main:
    push rbp
    mov  rbp, rsp


    mov  rdi, samuel_name
    xor  rsi, rsi
    mov  sil, [samuel_age]  ; sil is the lower 8 bits of rsi
    call init_employee
    mov  [samuel], rax

    mov  rdi, sally_name
    xor  rsi, rsi
    mov  sil, [sally_age]
    call init_employee
    mov  [sally], rax

    mov  rdi, susan_name
    xor  rsi, rsi
    mov  sil, [susan_age]
    call init_employee
    mov  [susan], rax

    mov  rdi, [samuel]
    call display_employee

    mov  rdi, [sally]
    call display_employee

    mov  rdi, [susan]
    call display_employee

    leave
    ret


