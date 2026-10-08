; you can declare any helper variables in .data or .bss

section .text

;; DO NOT MODIFY
global solve_labyrinth

solve_labyrinth:
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    r12
    push    r13
    push    r14
    push    r15

    mov     r12, rdi
    mov     r13, rsi
    mov     r14, rdx
    mov     r15, rcx
    mov     rbx, r8
    ;; DO NOT MODIFY
    ;; YOUR CODE STARTS HERE

    dec r14 ;m - 1 ultima linie
    dec r15 ;n - 1 ultima coloana

    xor r8, r8 ;linia curenta
    xor r9, r9 ;coloana curenta

start:
    cmp r8, r14 ;verificam daca am ajuns la ultima linie
    je gasit_iesire

    cmp r9, r15 ;verificam daca am ajuns la ultima coloana
    je gasit_iesire

    mov r10, [rbx + r8 * 8] ;adresa liniei curente din matrice
    mov byte [r10 + r9], '1' ;schimba din 0 in 1

jos:
    cmp r8, r14 ;verific daca pot sa merg in jos
    jge sus 

    mov r11, r8
    inc r11 

    mov r10, [rbx + r11 * 8] ;adresa liniei de jos
    cmp byte [r10 + r9], '0' ;verific daca elementul de jos e 0
    jne sus

    inc r8 
    jmp start 

sus:
    cmp r8, 0 ;verific daca pot sa merg in sus
    jle dreapta

    mov r11, r8
    dec r11 

    mov r10, [rbx + r11 * 8] ;adresa liniei de sus
    cmp byte [r10 + r9], '0' ;verific daca e liber
    jne dreapta

    dec r8
    jmp start

dreapta:
    cmp r9, r15 ;verific daca pot sa merg in dreapta
    jge stanga

    mov r10, [rbx + r8 * 8] ;adresa liniei curente
    mov r11, r9
    inc r11 

    cmp byte [r10 + r11], '0' ;verific daca in dreapta e liber
    jne stanga

    inc r9
    jmp start

stanga:
    cmp r9, 0 ;verific daca pot sa merg in stanga
    jle start 

    mov r10, [rbx + r8 * 8] ;adresa liniei curente
    mov r11, r9
    dec r11 

    cmp byte [r10 + r11], '0' ;verific daca e liber
    jne start

    dec r9
    jmp start

gasit_iesire:
    mov dword [r12], r8d ;salvam linia la care a iesit
    mov dword [r13], r9d ;salvam coloana la care a iesit

    ;; YOUR CODE ENDS HERE
    ;; DO NOT MODIFY
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
    ;; DO NOT MODIFY