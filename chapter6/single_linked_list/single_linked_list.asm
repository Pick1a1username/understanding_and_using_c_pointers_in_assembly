extern malloc
extern free

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
global initialize_list
initialize_list:
    section .text
        push rbp
        mov  rbp, rsp

        mov r12, rdi

        xor rsi, rsi
        mov [rdi], rsi          ; Set _l_head to NULL
        add rdi, _l_tail
        mov [rdi], rsi          ; Set _l_tail to NULL
        mov rdi, r12
        add rdi, _l_current
        mov [rdi], rsi          ; Set _l_current to NULL

        leave
        ret

;
;
; * Args
;   * rdi: the address of a list
;   * rsi: the address of data
global add_head
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
        mov  [rax], r13

        ; Check the head of the list
        mov rdi, [r12]
        cmp rdi, 0x0000000000000000
        jnz .yes_head

        ; If there is no head in the list, set the head to new node
        ; and set the next of new node to NULL
        .no_head:
        mov  rdi, r12
        add  rdi, _l_tail
        mov  [rdi], r14

        mov  rdi, r14
        add  rdi, _n_next
        xor  rsi, rsi
        mov  [rdi], rsi 

        jmp .last_step

        ; If there is a head in the list,
        ; set the next of new node to the head of the list.
        .yes_head:
        mov  rdi, r14
        add  rdi, _n_next
        mov  rsi, [r12]
        mov  [rdi], rsi

        ; Set the head of the list
        .last_step:
        mov [r12], r14

        leave
        ret

;
; * Args
;   * rdi: the address of a list
;   * rsi: the address of data
global add_tail
add_tail:
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
        mov [rax], r13

        ; Set the next of new node to NULL.
        add rax, _n_next
        xor rsi, rsi
        mov [rax], rsi

        ; Check the head of the list
        mov rdi, [r12]
        cmp rdi, 0x0000000000000000
        jnz .yes_head

        ; If there is no head in the list, set the head to new node.
        .no_head:
        mov  rdi, r12
        mov  [rdi], r14
        
        jmp .last_step

        ; If there is a head in the list,
        ; set the old tail's next to new node.
        .yes_head:
        mov rdi, r12
        add rdi, _l_tail
        mov rdi, [rdi]
        add rdi, _n_next
        mov [rdi], r14

        ; Set the tail of the list to new node
        .last_step:
        mov rdi, r12
        add rdi, _l_tail
        mov [rdi], r14

        leave
        ret

;
; * Args
;   * rdi: the address of a list
;   * rsi: the pointer to the compare function
;   * rdx: the address of data
; * Return
;   * The address of the node, if it is found
;   * NULL, if it is not found
global get_node
get_node:
    section .text
        push rbp
        mov  rbp, rsp
        
        mov r12, rdi  ; the address of a list
        mov r13, rsi  ; the pointer to the compare function
        mov r14, rdx  ; the address of data to get

        mov r15, [rdi]  ; the head node of the list
                        ; This will be set to the next node in every loop

        .compare_loop:
        mov  rdi, [r15]
        mov  rsi, r14
        call r13
        test rax, rax
        jz   .return_node

        add  r15, _n_next
        mov  r15, [r15]
        test r15, r15
        jnz  .compare_loop  ; loop if there is the next node.
        jmp  .return_null

        .return_node:
        mov rax, r15
        leave
        ret

        .return_null:
        xor rax, rax
        leave
        ret

;
; * Args
;   * rdi: the address of a list
;   * rsi: the address of a node
global delete
delete:
    section .text
        push rbp
        mov  rbp, rsp

        mov r12, rdi  ; the address of the list
        mov r13, rsi  ; the address of the node

        mov rdi, [r12]  ; the head node of the list
        cmp rdi, r13
        jz  .node_eq_list_head
        jmp .node_neq_list_head

        .node_eq_list_head:
        add  rdi, _n_next  ; the next node of the head node
        mov  rdi, [rdi]
        test rdi, rdi      ;
        jnz  .change_list_head

        ; Clear the head and the tail of the list.
        mov rdi, r12
        mov rsi, 0
        mov [rdi], rsi
        add rdi, _l_tail
        mov [rdi], rsi

        jmp .last_step

        ; Change the head of the list to the second node.
        .change_list_head:
        mov rdi, r12
        mov rsi, [r12]
        add rsi, _n_next
        mov rsi, [rsi]
        mov [rdi], rsi

        jmp .last_step

        .node_neq_list_head:
        mov rdi, [r12]  ; the head node of the list

        ; Find the previous node of the target node.
        .find_node:
        test rdi, rdi
        jz   .after_finding  ; if the node is NULL, stop the loop.

        mov rsi, rdi
        add rsi, _n_next
        mov rsi, [rsi]
        cmp rsi, r13
        jz  .after_finding  ; if the next node of the node is target node,
                            ; stop the loop.

        add rdi, _n_next
        mov rdi, [rdi]  ; Get the next node.
        jmp .find_node

        .after_finding:
        test rdi, rdi
        jz   .last_step  ; if the node is NULL,
                         ; free target node immediately.

        add rdi, _n_next
        mov rsi, r13
        add rsi, _n_next
        mov rsi, [rsi]
        mov [rdi], rsi
        
        .last_step:
        mov  rdi, r13
        call free

        leave
        ret

