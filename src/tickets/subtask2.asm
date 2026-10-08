; write the structures
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
global filter_flights

; void filter_flights(struct flight* origFlights, struct flight* finalFlights
;						 int* nrFlights, int min_bag_weight)
; rdi = struct flight *origFlights
; rsi = struct flight *finalFlights
; rdx = int *nrFlights
; rcx = int min_bag_weight
filter_flights:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	xor r8, r8 ;index vector vechi
	xor r9, r9 ;index vector nou
	xor r10, r10 ;nr de zboruri
	mov r11d, dword [rdx]

start:
	cmp r11, 0 ;vad daca am parcurs tot vectorul
	je end 

	cmp word [rdi + r8 + 38], cx ;daca nu, vad daca bagajul e mai mare decat minimul
	jnge index

	mov rax, [rdi + r8 + 0] ;copiez 8 bytes in rax
	mov [rsi + r9 + 0], rax ;si ii pun in vectorul nou

	mov rax, [rdi + r8 + 8] ;copiez 8 bytes in rax
	mov [rsi + r9 + 8], rax ;si ii pun in vectorul nou

	mov rax, [rdi + r8 + 16] ;copiez 8 bytes in rax
	mov [rsi + r9 + 16], rax ;si ii pun in vectorul nou

	mov rax, [rdi + r8 + 24] ;copiez 8 bytes in rax
	mov [rsi + r9 + 24], rax ;si ii pun in vectorul nou

	mov rax, [rdi + r8 + 32] ;copiez 8 bytes in rax
	mov [rsi + r9 + 32], rax ;si ii pun in vectorul nou

	mov ax, [rdi + r8 + 40] ;copiez ultimii 2 bytes in ax
	mov [rsi + r9 + 40], ax ;si ii pun in vectorul nou

	add r9, 42 ;cresc indexul pt vect nou
	inc r10

index:
	add r8, 42 ;daca bagajul e mai mic cresc doar indexul vectorului vechi
	dec r11
	jmp start

end:
	mov [rdx], r10d

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

	leave
	ret