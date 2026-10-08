section .text

;; DO NOT MODIFY
global check_column
global check_row
global check_box

; int check_row(int **array, int size, int rowNr)
; rdi = int **array
; rsi = int size
; rdx = int rowNr
check_row:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	xor r8, r8 ;linia
	xor r9, r9 ;coloana

	xor r10, r10 ;iteratia
	xor r11, r11 ;lungimea
	mov r12, [rdi + rdx * 8] ;adresa inceputului de linie

	mov r11, rsi
	dec r11 ;calculez lungimea - 1

start_lin:
	cmp r10, r11
	jge ok_lin

	mov r8d, dword [r12 + r10 * 4] ;punem 4 bytes, fix un int

	mov r9, r10
	inc r9

verificare_lin:
	cmp r9, r11 ;vad daca am parcurs toata linia
	je next_lin

	mov r13d, dword [r12 + r9 * 4] ;elementul de la pozitia j

	cmp r8d, r13d ;compar elementele
	je not_ok_lin

	inc r9
	jmp verificare_lin

next_lin:
	inc r10
	jmp start_lin

ok_lin:
	mov rax, 1 ;1 daca linia este corecta
	jmp end_lin

not_ok_lin:
	mov rax, 0 ;0 daca avem dubluri pe linie
	jmp end_lin

end_lin:

	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY

;; DO NOT MODIFY
; int check_column(int **array, int size, int columnNr)
; rdi = int **array
; rsi = int size
; rdx = int columnNr
check_column:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	xor r8, r8 ;linia
	xor r9, r9 ;coloana

	xor r10, r10 ;iteratia
	xor r11, r11 ;lungimea

	mov r11, rsi
	dec r11 ;calculez lungimea - 1

start_col:
	cmp r10, r11
	jge ok_col

	mov r12, [rdi + r10 * 8] ;adresa inceputului de linie i
	mov r8d, dword [r12 + rdx * 4] ;elementul de la pozitia i de pe coloana

	mov r9, r10
	inc r9

verificare_col:
	cmp r9, r11 ;vad daca am parcurs toata coloana
	je next_col

	mov r14, [rdi + r9 * 8] ;adresa inceputului de linie j
	mov r13d, dword [r14 + rdx * 4] ;elementul de la pozitia j de pe coloana

	cmp r8d, r13d ;compar elementele
	je not_ok_col

	inc r9
	jmp verificare_col

next_col:
	inc r10
	jmp start_col

ok_col:
	mov rax, 1 ;1 daca coloana este corecta
	jmp end_col

not_ok_col:
	mov rax, 0 ;0 daca avem dubluri pe coloana
	jmp end_col

end_col:
	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY

;; DO NOT MODIFY
; int check_box(int **array, int size, int boxNr)
; rdi = int **array
; rsi = int size
; rdx = int boxNr
check_box:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	mov r12, rdx ;salvez indexul cutiei

	mov rbx, 1 ;initializez latura
latura:
	mov rax, rbx
	mul rbx

	cmp rax, rsi ;caut radacina patrata a dimensiunii
	je gasita

	inc rbx
	jmp latura

gasita:
	mov rax, r12
	xor rdx, rdx

	div rbx
	mul rbx

	mov r14, rax ;calculez linia de start a cutiei

	mov rax, r12
	xor rdx, rdx

	div rbx
	mov rax, rdx

	mul rbx
	mov r15, rax ;calculez coloana de start a cutiei

	xor r8, r8 ;elementul de la pozitia i
	xor r13, r13 ;elementul de la pozitia j

	xor r10, r10 ;iteratia
	xor r11, r11 ;lungimea

	mov r11, rsi

start_box:
	cmp r10, r11
	jge ok_box

	mov rax, r10
	xor rdx, rdx
	div rbx

	add rax, r14 ;linia elementului i
	add rdx, r15 ;coloana elementului i

	mov rcx, [rdi + rax * 8] ;adresa inceputului de linie
	mov r8d, dword [rcx + rdx * 4] ;elementul de la pozitia i din cutie

	mov r9, r10
	inc r9

verificare_box:
	cmp r9, r11 ;vad daca am parcurs toata cutia
	jge next_box

	mov rax, r9
	xor rdx, rdx
	div rbx

	add rax, r14 ;linia elementului j
	add rdx, r15 ;coloana elementului j

	mov rcx, [rdi + rax * 8] ;adresa inceputului de linie
	mov r13d, dword [rcx + rdx * 4] ;elementul de la pozitia j din cutie

	cmp r8d, r13d ;compar elementele
	je not_ok_box

	inc r9
	jmp verificare_box

next_box:
	inc r10
	jmp start_box

ok_box:
	mov rax, 1 ;1 daca cutia este corecta
	jmp end_box

not_ok_box:
	mov rax, 0 ;0 daca avem dubluri in cutie
	jmp end_box

end_box:
	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
