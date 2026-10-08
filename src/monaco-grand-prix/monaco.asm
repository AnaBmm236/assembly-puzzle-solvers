section .text

;; DO NOT MODIFY
global fix_lap_times


fix_lap_times:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    ;; DO NOT MODIFY
    ;; YOUR CODE STARTS HERE

    mov r11, rdx ;lungimea 
    xor r10, r10 ;iteratia
    xor r12, r12 ;counter pentru erori

start:
    cmp r10, r11 ;verific daca am parcurs tot vectorul
    jge final

    xor rax, rax
    mov al, byte [rsi + r10] ;pun in al flagul de eroare
    cmp al, 1 ;verific daca avem eroare
    je caz_eroare

caz_ok:
    mov eax, dword [rdi + r10 * 4] ;iau elementul din input
    mov dword [rcx + r10 * 4], eax ;il pun in output
    jmp next

caz_eroare:
    inc r12 ;cresc nr de erori

    cmp r10, 0 ;verific daca e primul element
    je primul_element

    mov r13, r11
    dec r13 ;ultimul index
    cmp r10, r13 ;verific daca e ultimul element
    je ultimul_element

element_mijloc:
    mov r9, r10
    dec r9
    mov eax, dword [rdi + r9 * 4] ;iau timpul anterior din vector

    mov r9, r10
    inc r9
    mov r14d, dword [rdi + r9 * 4] ;iau timpul urmator din vector

    add eax, r14d ;le adun
    shr eax, 1 ;impart la 2

    mov dword [rcx + r10 * 4], eax ;salvez timpul reparat in output
    jmp next

primul_element:
    mov r9, r10
    inc r9
    mov eax, dword [rdi + r9 * 4] ;iau elementul urmator
    mov dword [rcx + r10 * 4], eax ;il pun in output
    jmp next

ultimul_element:
    mov r9, r10
    dec r9
    mov eax, dword [rdi + r9 * 4] ;iau elementul anterior
    mov dword [rcx + r10 * 4], eax ;il pun in output
    jmp next

next:
    inc r10
    jmp start

final:
    mov dword [r8], r12d ;pun nr total de erori in r8

    ;; YOUR CODE ENDS HERE
    ;; DO NOT MODIFY
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
    ;; DO NOT MODIFY