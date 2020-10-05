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

  ; save RBX
  mov [RBP], RBX

  xor RBX, RBX
  mov EBX, EDI

  ; print welcome message to prove fizzbuzz is writen in assembly
  lea RDI, [REL welcome]
  call printf  WRT ..plt

  .main_loop:
    ; initialize bitmask
    ; 1          1
    ; ^ p fizz   ^ p buzz
    mov WORD [RBP+0x10], 0

    .test_fizz:
      mov EDX, 0
      mov EAX, DWORD [RBP + 0x8]
      mov ECX, 3
      div ECX

      test EDX, EDX
      jne .test_buzz
      mov WORD [RBP+0x10], 1b

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
      mov DX, WORD [RBP+0x10]
      and EDX, 1b
      test EDX, EDX
      je .first_check
      lea RDI, [REL fizz]
      call printf  WRT ..plt

      .first_check:
      ; check buzz
      mov DX, WORD [RBP+0x10]
      and EDX, 10b
      test EDX, EDX
      je .second_check
      lea RDI, [REL buzz]
      call printf  WRT ..plt

      .second_check:
      ; check no other case is set
      mov DX, WORD [RBP+0x10]
      test DX, DX
      jne .while_loop

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
  message: db "This number: %d", 0x0
  welcome: db "Fizz buzz in pure assembly", 0xA, 0x0
  fizz: db "Fizz", 0
  buzz: db "Buzz", 0
  newline: db 0xA, 0
