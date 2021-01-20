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
  
; * Args
;   * rdi: the address of name(string)
;   * rsi: age(unsigned integer)
; * Return: The address of the new employee
init_employee:
    section .text
        push rbp
        mov  rbp, rsp
        push r12
    
        mov  r10, rdi      ; the address of name
        mov  r11, rsi      ; age
        
        ; Allocate the memory from heap
        xor  rdi, rdi      ; rdi must be initialized!
        mov  rdi, _e_age  ; the size of _e_name
        add  rdi, 1       ; the size of _e_age
        push r10
        push r11
        call malloc
        pop  r11
        pop  r10
        mov  r12, rax     ; Backup the address of employee

        ; Set name
        lea  rdi, [r12]
        lea  rsi, [r10]
        push r10
        push r11
        push r12          ; for stack alignment
        call strcpy
        pop  r12
        pop  r11
        pop  r10

        ; Set age
        lea  rdi, [r12]
        add  rdi, _e_age
        mov  [rdi], r11
        xor  rdi, rdi
        xor  rsi, rsi

        mov  rax, r12

        pop r12
        leave
        ret

; * Args
;    * rdi: the address of employee
display_employee:
    section .data
        .fmt  db  `%s\t%d\n`, 0
    section .text
        push rbp
        mov  rbp, rsp

        mov  r10, rdi  ; the address of employee

        mov  rdi, .fmt
        mov  rsi, r10     ; name
        mov  rdx, r10 
        add  rdx, _e_age  
        mov  rdx, [rdx]   ; age
        call printf

        leave
        ret




 

