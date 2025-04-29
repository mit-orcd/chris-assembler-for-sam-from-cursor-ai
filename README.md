# x86 Assembly Examples

This repository contains three assembly programs:
1. A simple "hello world" program in x86 assembly
2. A floating point addition program in x86 assembly
3. A floating point addition program in NVIDIA PTX assembly

## Prerequisites

- NASM (Netwide Assembler)
- ld (GNU Linker)
- gcc (for the floating point examples)
- NVIDIA CUDA Toolkit (for the PTX example)
- A Linux environment (or WSL on Windows)

## Hello World Program

### Building and Running

1. Assemble the program:
```bash
nasm -f elf32 hello.asm
```

2. Link the object file:
```bash
ld -m elf_i386 -o hello hello.o
```

3. Run the program:
```bash
./hello
```

### Program Explanation

The program consists of two main sections:

1. `.data` section:
   - Contains the string "hello world" with a newline character
   - Calculates the length of the string

2. `.text` section:
   - Uses Linux system calls to write to stdout and exit
   - `_start` is the program entry point
   - Uses syscall 4 (write) to print the message
   - Uses syscall 1 (exit) to terminate the program

## x86 Floating Point Addition Program

### Building and Running

1. Assemble the program:
```bash
nasm -f elf32 float_add.asm
```

2. Link with gcc:
```bash
gcc -m32 -o float_add float_add.o
```

3. Run the program:
```bash
./float_add
```

### Program Explanation

This program adds two 64-bit floating point numbers (3.14159 and 2.71828) using the x87 FPU.

1. `.data` section:
   - Contains the two numbers to be added
   - Storage for the result
   - Format string for printf

2. `.text` section:
   - Uses x87 FPU instructions for floating point operations
   - `finit` initializes the FPU
   - `fld` loads numbers onto the FPU stack
   - `fadd` performs the addition
   - Uses printf to display the result

## NVIDIA PTX Floating Point Addition Program

### Building and Running

1. Compile the PTX code with NVCC:
```bash
nvcc -ptx float_add.ptx
```

2. Compile and link the C wrapper:
```bash
nvcc -o float_add_ptx float_add_ptx.c float_add.ptx
```

3. Run the program:
```bash
./float_add_ptx
```

### Program Explanation

This program demonstrates floating point addition using NVIDIA's PTX assembly language, which is used for GPU programming.

1. PTX Assembly Features:
   - Uses `.version 7.0` for PTX ISA version
   - Targets compute capability 5.0 (sm_50)
   - Uses 64-bit addressing
   - Implements a function that takes two double-precision floating point numbers and returns their sum

2. Key PTX Instructions:
   - `ld.param.f64`: Loads double-precision parameters
   - `add.f64`: Performs double-precision addition
   - `st.param.f64`: Stores the result

## System Calls Used (Hello World)

- `write` (syscall 4): Writes data to a file descriptor
  - ebx: file descriptor (1 for stdout)
  - ecx: pointer to the message
  - edx: length of the message

- `exit` (syscall 1): Terminates the program
  - ebx: exit code (0 for success) 