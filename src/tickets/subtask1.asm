; write the structures. make sure it fits the layour in the README
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
global apply_delay

; void apply_delay(struct flight* flights, int nrFlights)
; rdi = struct flight *flightss
; rsi = int nrFlights
apply_delay:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	xor r8, r8 ;index
	xor r9, r9 ;minute
	xor r10, r10 ;ore

start:
	cmp rsi, 0 ;verificam daca am parcurs tot vectorul
	je end2

	mov r9b, byte [rdi + r8 + 40] ;pune in r9 minutele
	mov r10b, byte [rdi + r8 + 41] ;pune in r10 orele

	add byte [rdi + r8 + 34], r9b ;adaug delayul de minute la plecare
	cmp byte [rdi + r8 + 34], 60 ;vad daca trece de 60 de minute
	jnge next1

	add byte [rdi + r8 + 33], 1 ;daca da adauga o ora
	sub byte [rdi + r8 + 34], 60 ;si imi calculeaza minutele

next1:
	add byte [rdi + r8 + 33], r10b ;adaug delayul de ora la plecare
	cmp byte [rdi + r8 + 33], 24 ;vad daca trece de 24 de ore
	jnge next2

	add byte [rdi + r8 + 32], 1 ;daca da adaug o zi
	sub byte [rdi + r8 + 33], 24 ;calculez orele

next2:
	add byte [rdi + r8 + 37], r9b ;adaug delayul de minute la venire
	cmp byte [rdi + r8 + 37], 60 ;vad daca trece de 60 de minute
	jnge next3

	add byte [rdi + r8 + 36], 1 ;daca da adauga o ora
	sub byte [rdi + r8 + 37], 60 ;si imi calculeaza minutele

next3:
	add byte [rdi + r8 + 36], r10b ;adaug delayul de ora la venire
	cmp byte [rdi + r8 + 36], 24 ;vad daca trece de 24 de ore
	jnge end1

	add byte [rdi + r8 + 35], 1 ;daca da adaug o zi
	sub byte [rdi + r8 + 36], 24 ;calculez orele

end1:
	add r8, 42 ;trec la urmatorul zbor
	dec rsi
	jmp start

end2:

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
