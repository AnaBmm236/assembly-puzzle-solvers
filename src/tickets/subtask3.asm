; write the structure
; struct flight
; 		TODO
; endstruct

struc Time
	day: resb 1
	hour: resb 1
	minutes: resb 1
endstruc

struc structura
	destination: resb 32 ;offset 0
	departingTime: resb 3 ;offset 32
	arrivingTime: resb 3 ;;offset 35
	bag_weight: resw 1 ;offset 38
 	delayMinutes: resb 1 ;offset 40
	delayHours: resb 1 ;offset 41
endstruc

section .text

;; DO NOT MODIFY
global sort_and_return

; int sort_and_return(struct flight* flights, int nrFlights, 
;                      struct flight* bestFlight, char destination[32])
; rdi = flights (pointer)
; rsi = nrFlights (value)
; rdx = bestFlight (pointer to pre-allocated struct)
; rcx = destination (pointer to 32-byte string)
sort_and_return:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

start:
	xor r8, r8 ;index vector
	xor r9, r9 ;pt a vedea daca am facut vreo interschimbare

	mov r10, rsi
	dec r10

comparare:
	;zi
	mov al, byte [rdi + r8 + 35] ;imi pune in al ziua zborului curent
	mov bl, byte [rdi + r8 + 35 + 42] ;imi pune in bl ziua urmatorului zbor

	cmp al, bl ;verific care zi este mai mica
	jl next
	jne diferite

	;ora
	mov al, byte [rdi + r8 + 36]
	mov bl, byte [rdi + r8 + 36 + 42] ;punem in bl ora zborului urmator

	cmp al, bl
	jl next
	jne diferite

	;minute
	mov al, byte [rdi + r8 + 37]
	mov bl, byte [rdi + r8 + 37 + 42] ;punem in bl minutele zborului urmator

	cmp al, bl
	jl next
	jne diferite

	mov ax, [rdi + r8 + 38] ;punem in ax greutatea bagajului zborului curent
	mov bx, [rdi + r8 + 38 + 42] ;punem in bx greutatea bagajului zborului urmator

	cmp ax, bx
	jg next
	je next

diferite:
	mov rax, [rdi + r8 + 0] ;punem in rax 8 bytes din zborul curent
	mov rbx, [rdi + r8 + 0 + 42] ;punem in rbx 8 bytes din zborul urmator
	mov [rdi + r8 + 0], rbx ;pune rbx in spatiul din zborul curent
	mov [rdi + r8 + 0 + 42], rax ;pune rax in spatiul din zborul urmator 

	mov rax, [rdi + r8 + 8] ;pune in rax urmatorii 8 bytes din zborul curent
	mov rbx, [rdi + r8 + 8 + 42] ;punem in rbx urmatorii 8 bytes din zborul urmator
	mov [rdi + r8 + 8], rbx ;pune rbx in spatiul din zborul curent
	mov [rdi + r8 + 8 + 42], rax ;pune rax in spatiul din zborul urmator 

	mov rax, [rdi + r8 + 16] ;pune in rax urmatorii 8 bytes din zborul curent
	mov rbx, [rdi + r8 + 16 + 42] ;punem in rbx urmatorii 8 bytes din zborul urmator
	mov [rdi + r8 + 16], rbx ;pune rbx in spatiul din zborul curent
	mov [rdi + r8 + 16 + 42], rax ;pune rax in spatiul din zborul urmator 

	mov rax, [rdi + r8 + 24] ;pune in rax urmatorii 8 bytes din zborul curent
	mov rbx, [rdi + r8 + 24 + 42] ;punem in rbx urmatorii 8 bytes din zborul urmator
	mov [rdi + r8 + 24], rbx ;pune rbx in spatiul din zborul curent
	mov [rdi + r8 + 24 + 42], rax ;pune rax in spatiul din zborul urmator 

	mov rax, [rdi + r8 + 32] ;pune in rax urmatorii 8 bytes din zborul curent
	mov rbx, [rdi + r8 + 32 + 42] ;punem in rbx urmatorii 8 bytes din zborul urmator
	mov [rdi + r8 + 32], rbx ;pune rbx in spatiul din zborul curent
	mov [rdi + r8 + 32 + 42], rax ;pune rax in spatiul din zborul urmator 

	mov ax, [rdi + r8 + 40] ;pune in ax urmatorii 8 bytes din zborul curent
	mov bx, [rdi + r8 + 40 + 42] ;punem in bx urmatorii 8 bytes din zborul urmator
	mov [rdi + r8 + 40], bx ;pune bx in spatiul din zborul curent
	mov [rdi + r8 + 40 + 42], ax ;pune ax in spatiul din zborul urmator 

	mov r9, 1 ;fac 1 pt ca s a realizat o interschimbare

next:
	add r8, 42 ;trecem la urmatorul zbor
	dec r10
	cmp r10, 0 ;verificam daca am parcurs tot vectorul
	jne comparare

	cmp r9, 1 ;verificam daca s-a facut vreo interschimbare
	je start

	xor r8, r8 ;index
	mov r10, rsi

find:
	cmp r10, 0 ;verificam daca mai avem zboruri de comparat
	je negasit

	mov rax, [rdi + r8 + 0] ;ia primele 8 litere din numele zborului curent
	cmp rax, [rcx + 0] ;le compara cu primele 8 litere din destinatia cautata
	jne next_find

	mov rax, [rdi + r8 + 8] ;ia urmatoarele 8 litere 
	cmp rax, [rcx + 8] ;si le compara cu urmatoarele 8 din destinatia cautata
	jne next_find

	mov rax, [rdi + r8 + 16] ;ia urmatoarele 8 litere
	cmp rax, [rcx + 16] ;si le compara cu urmatoarele 8
	jne next_find

	mov rax, [rdi + r8 + 24] ;ia urmatoarele 8 litere
	cmp rax, [rcx + 24] ;si le compara cu urmatoarele 8
	jne next_find

	jmp end_found

next_find:
	dec r10
	add r8, 42 ;trecem la urmatorul zbor
	jmp find

negasit:
	mov rax, 0 ;punem 0 pt ca nu a fost gasit
	mov rdx, 0 ;punem NULL
	jmp end

end_found:
	mov rax, [rdi + r8 + 0] ;pun 8 bytes in rax din zborul gasit
	mov [rdx + 0], rax ;pun rax in structura in care trebuie copiat

	mov rax, [rdi + r8 + 8] ;pun urmatorii 8 bytes in rax din zborul gasit
	mov [rdx + 8], rax ;pun rax in structura in care trebuie copiat

	mov rax, [rdi + r8 + 16] ;pun urmatorii 8 bytes in rax din zborul gasit
	mov [rdx + 16], rax ;pun rax in structura in care trebuie copiat

	mov rax, [rdi + r8 + 24] ;pun urmatorii 8 bytes in rax din zborul gasit
	mov [rdx + 24], rax ;pun rax in structura in care trebuie copiat

	mov rax, [rdi + r8 + 32] ;pun urmatorii 8 bytes in rax din zborul gasit
	mov [rdx + 32], rax ;pun rax in structura in care trebuie copiat

	mov ax, [rdi + r8 + 40] ;pun urmatorii 8 bytes in ax din zborul gasit
	mov [rdx + 40], ax ;pun ax in structura in care trebuie copiat

	mov rax, 1 ; 1 pt ca zborul a fost gasit

end:

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