extern malloc

struc _node
    _n_data:  resq 1  ; the address of data of the node
    _n_next:  resq 1  ; the address of the next node
endstruc

struc _linkedList
    _l_head:     resq 1  ; the address of the head node
    _l_tail:     resq 1  ; the address of the tail node
    _l_current:  resq 1  ; the address of the current node
endstruc

section .text

;
;
; * Args
;   * rdi: the address of a list
; global initialize_list
initialize_list:
    section .text
        push rbp
        mov  rbp, rsp

        mov  rdi, 0          ; Set _l_head to NULL
        add  rdi, _l_tail
        mov  rdi, 0          ; Set _l_tail to NULL
        add  rdi, _l_current
        mov  rdi, 0          ; Set _l_current to NULL

        leave
        ret

;
;
; * Args
;   * rdi: the address of a list
;   * rsi: the address of data
; global add_head
add_head:
    section .text
        push rbp
        mov  rbp, rsp

        mov r12, rdi  ; the address of a list
        mov r13, rsi  ; the address of data

        ; Allocate memory for new node
        xor  rdi, rdi
        mov  rdi, _n_data
        add  rdi, _n_next
        add  rdi, 8
        call malloc
        mov  r14, rax         ; the address of new node

        ; Set the data of new node to
        ; the address of data passed as an argument.
        mov  rax, r13

        ; Check the head of the list
        test r12, 0x0000000000000000
        jnz .yes_head

        ; If there is no head in the list, set the head to new node
        ; and set the next of new node to NULL
        .no_head:
        mov  rdi, r12
        add  rdi, _l_tail
        mov  [rdi], r14

        mov  rdi, r14
        add  rdi, _n_next
        mov  rdi, 0        ; Is this okay?

        jmp .last_step

        ; If there is a head in the list,
        ; set the next of new node to the head of the list.
        .yes_head:
        mov  rdi, r14
        add  rdi, _n_next
        mov  rdi, r12 

        ; Set the head of the list
        .last_step:
        mov [r12], r14

        leave
        ret








 

