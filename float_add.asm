section .data
    num1 dq 3.14159      ; first number
    num2 dq 2.71828      ; second number
    result dq 0.0        ; storage for result
    format db "Result: %f", 10, 0  ; format string for printf

section .text
    global main
    extern printf

main:
    ; Initialize FPU
    finit

    ; Load first number
    fld qword [num1]

    ; Add second number
    fadd qword [num2]

    ; Store result
    fstp qword [result]

    ; Prepare for printf call
    push dword [result+4]    ; push high 32 bits of result
    push dword [result]      ; push low 32 bits of result
    push format             ; push format string
    call printf
    add esp, 12             ; clean up stack

    ; Exit
    mov eax, 0
    ret 