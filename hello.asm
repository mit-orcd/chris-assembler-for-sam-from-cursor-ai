section .data
    msg db 'hello world', 0xa  ; string to print with newline
    len equ $ - msg            ; length of the string

section .text
    global _start

_start:
    ; write syscall
    mov eax, 4      ; syscall number for write
    mov ebx, 1      ; file descriptor 1 (stdout)
    mov ecx, msg    ; pointer to message
    mov edx, len    ; message length
    int 0x80        ; call kernel

    ; exit syscall
    mov eax, 1      ; syscall number for exit
    mov ebx, 0      ; exit code 0
    int 0x80        ; call kernel 