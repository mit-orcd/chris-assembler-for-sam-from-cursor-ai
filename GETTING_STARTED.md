# Getting Started with Assembly Language

This guide is designed to help you get familiar with assembly language concepts before taking MIT 6.004 (Computation Structures). We'll use simple examples to explain key concepts and show how assembly language bridges the gap between high-level programming and hardware.

## What is Assembly Language?

Assembly language is a low-level programming language that's very close to machine code. While high-level languages like Python or Java are designed to be human-readable and abstract away hardware details, assembly language gives you direct control over the computer's hardware.

Think of it like this:
- High-level languages: "Print 'hello world'"
- Assembly language: "Move this value to register A, then call the system function to write to screen"

## Basic Concepts

### 1. Registers
Registers are small storage locations inside the CPU. They're like variables, but much faster to access. In our examples:
- `eax`, `ebx`, `ecx`, `edx` are general-purpose registers
- `f0`, `f1`, `f2` are floating-point registers in PTX

### 2. Instructions
Assembly instructions are the basic operations the CPU can perform. For example:
- `mov`: Move data between registers or memory
- `add`: Add two numbers
- `int`: Call a system function

### 3. Memory
Assembly programs can access both registers and main memory. Memory addresses are like street addresses for data.

## Learning with Our Examples

### Example 1: Hello World (`hello.asm`)
This simple program shows how to interact with the operating system:

```assembly
section .data
    msg db 'hello world', 0xa  ; Define a string in memory
    len equ $ - msg            ; Calculate its length

section .text
    global _start

_start:
    mov eax, 4      ; System call for 'write'
    mov ebx, 1      ; File descriptor 1 (stdout)
    mov ecx, msg    ; Pointer to message
    mov edx, len    ; Message length
    int 0x80        ; Call the kernel
```

Key concepts demonstrated:
- Data section vs. text section
- System calls
- Register usage
- Memory addressing

### Example 2: Floating Point Addition (`float_add.asm`)
This program shows how to work with floating-point numbers:

```assembly
section .data
    num1 dq 3.14159      ; First number
    num2 dq 2.71828      ; Second number
    result dq 0.0        ; Storage for result

section .text
    global main
    extern printf

main:
    finit               ; Initialize FPU
    fld qword [num1]    ; Load first number
    fadd qword [num2]   ; Add second number
    fstp qword [result] ; Store result
```

Key concepts demonstrated:
- Floating-point operations
- FPU (Floating Point Unit) instructions
- Memory storage for floating-point values

### Example 3: GPU Assembly (`float_add.ptx`)
This shows how assembly works on GPUs:

```ptx
.version 7.0
.target sm_50

.visible .entry float_add(
    .param .f64 a,
    .param .f64 b,
    .param .f64 result
) {
    .reg .f64 %f<3>;
    ld.param.f64 %f1, [a];
    ld.param.f64 %f2, [b];
    add.f64 %f3, %f1, %f2;
    st.param.f64 [result], %f3;
}
```

Key concepts demonstrated:
- Parallel processing
- GPU-specific instructions
- Parameter passing

## Why Learn Assembly for 6.004?

6.004 will teach you about:
1. Digital logic and computer architecture
2. How processors execute instructions
3. Memory hierarchy and organization
4. Parallel processing

Understanding assembly language helps you:
- See how high-level code translates to machine instructions
- Understand processor architecture
- Appreciate performance considerations
- Debug complex programs

## Next Steps

1. Try modifying our examples:
   - Change the hello world message
   - Use different numbers in the floating-point addition
   - Add more operations to the PTX code

2. Learn about:
   - Different instruction sets (x86, ARM, RISC-V)
   - Memory addressing modes
   - System calls and interrupts
   - Optimization techniques

3. Resources for 6.004:
   - Course website and materials
   - Digital Design and Computer Architecture textbooks
   - Online assembly language tutorials
   - Processor documentation

Remember: Assembly language is a tool to understand how computers work at their most fundamental level. Don't worry if it seems complex at first - the concepts will become clearer as you progress through 6.004! 