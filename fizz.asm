section .text

EXTERN printf
EXTERN exit

GLOBAL detect_fizz_buzz

detect_fizz_buzz:
  push RBP
  sub RSP, 0x8 * 4 ; reserve 4 variables
  mov RBP, RSP

  ; initialize counter
  mov QWORD [RBP+0x8], 1

  ; save RBX (arg 1)
  mov [RBP], RBX

  xor RBX, RBX
  mov EBX, EDI

  ; print welcome message to prove fizzbuzz is writen in assembly
  ; lea RDI, [REL welcome]
  ; call printf  WRT ..plt

  .main_loop:
    ; initialize bitmask
    ; 1          1
    ; ^ p fizz   ^ p buzz
    mov WORD [RBP+0x10], 0

    ; Check if the value is divisible by 3,
    ; if it is, it'll set the first bit to 1
    .test_fizz:
      mov EDX, 0
      mov EAX, DWORD [RBP + 0x8]
      mov ECX, 3
      div ECX

      test EDX, EDX
      jne .test_buzz
      or WORD [RBP+0x10], 01b

    ; Check if the value is divisible by 5.
    ; if true, it'll OR the saved value with 10b
    .test_buzz:
      mov EDX, 0
      mov EAX, DWORD [RBP + 0x8]
      mov ECX, 5
      div ECX

      test EDX, EDX
      jne .normal_case
      or WORD [RBP+0x10], 10b

    .normal_case:
      ; check fizz
      mov R12W, WORD [RBP+0x10]
      test R12W, 1b
      jz .first_check
      lea RDI, [REL fizz]
      call printf  WRT ..plt

      .first_check:
      ; check buzz
      test R12W, 10b
      jz .second_check
      lea RDI, [REL buzz]
      call printf  WRT ..plt

      .second_check:
      ; check no other case is set,
      ; to see if we should print a new line
      test R12W, R12W
      jnz .while_loop

      ; print current number
      lea RDI, [REL message]
      mov RSI, QWORD [RBP + 0x8]
      call printf  WRT ..plt


    .while_loop:
    lea RDI, [REL newline]
    call printf  WRT ..plt
    inc QWORD [RBP + 0x8]
    cmp QWORD [RBP + 0x8], RBX
    jle .main_loop


  ; restore stack
  mov RBX, [RBP]
  add RSP, 0x8 * 4
  pop RBP

  ret

main:
  push RBX

  mov RDI, 100
  call detect_fizz_buzz

	mov rax, 60
  call exit WRT ..plt

section .data
  message: db "%d", 0x0
  welcome: db "Fizz buzz in pure assembly", 0xA, 0x0
  fizz: db "Fizz", 0
  buzz: db "Buzz", 0
  newline: db 0xA, 0
