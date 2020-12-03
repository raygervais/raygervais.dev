---
title: "Compiler Vectorization in Assembly"
date: 2017-03-11
draft: false
tags: ["Open Source", "Seneca", "SPO600", "C"]
description: "For this exercise, we were tasked with the following instructions, cautioned that only ones with patience would achieve completion of this lab with their sanity intact."
---

_SPO600 Week Six Deliverable_

# Introduction

For this exercise, we were tasked with the following instructions, cautioned that only ones with patience would achieve completion of this lab with their sanity intact:

1. Write a short program that creates two 1000-element integer arrays and fills them with random numbers, then sums those two arrays to a third array, and finally sums the third array to a long int and prints the result.
2. Compile this program on an aarch64 machine in such a way that the code is auto-vectorized.
3. Annotate the emitted code (i.e., obtain a disassembly via objdump -d and add comments to the instructions in <main> explaining what the code does).
4. Review the vector instructions for AArch64. Find a way to scale an array of sound samples (see Lab 5) by a factor between 0.000-1.000 using SIMD.

# Step 1

Below, I’ve included the simplistic C code which would achieve the desired functionality. It’s very easy to read, with not complexity outside the realms of a standard math incremental operation, and the ever so popular addition operator. Included, is also a random number generator being drive by stdlib’s rand() function. Originally, I had the the calculations relating to the c array to be in a separate for loop, with the result calculation occurring in that for statement as well. This was moved into the loop used by variables a and b, making the program run O(n) instead of O(2n).

## C Code

```c
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define SIZE 1000

int main() {
        int a[SIZE]
            , b[SIZE]
            , c[SIZE];

        time_t t;
        long int result = 0;

        // Init Random Number Generator
        srand((unsigned) time(&t));

        int i;
        for(i = 0; i < SIZE; i++) {
                // Fill Arrays with Random Numbers
                a[i] =  rand() % 10;
                b[i] =  rand() % 10;

                // Sum Array Values into C[]
                c[i] = a[i] + b[i];

                // result stores final calculation
                result += c[i];
        }

        printf("Final Result: %ld \n", result);
        return 0;
}
```

# Step 2

To compile the application in such a way that the compiler utilizes advanced optimization techniques, I used the -O3 argument which incorporates vectorization where possible by default. Had I not wanted to use O3, I could instead use the -ftree-vectorize which provides the same desired optimization.

`gcc -o lab06 -O3 Vector.c`

## What is Auto-Vectorization?

The great wonder which is Wikipedia has the following explanation, which I shamelessly have posted below to supplement the answer to this question:

> **Automatic vectorization**, in [parallel computing](https://en.wikipedia.org/wiki/Parallel_computing), is a special case of automatic [parallelization](https://en.wikipedia.org/wiki/Parallelization), where a [computer program](https://en.wikipedia.org/wiki/Computer_program) is converted from a [scalar](https://en.wikipedia.org/wiki/Scalar_%28computing%29) implementation, which processes a single pair of [operands](https://en.wikipedia.org/wiki/Operand) at a time, to a [vector](https://en.wikipedia.org/wiki/Array_data_structure) implementation, which processes one operation on multiple pairs of operands at once.

# Step 3

Below is my included analysis of the lab06 file, including my comments on the right side. Viewing of such data was made possible by using objdump -d command, and then for editing purposes routing said command’s output into an empty .asm file. I will not deny that my analysis has many plot holes, full of assumptions that are incorrect or misread Assembly code or incorrect parsing of arguments. Regardless of the vectorization, Machine Language is the closest this web developer has ever gotten to the CPU and hardware itself. Would I say I enjoy reading Assembly Code? No. Do I see where it is an invaluable source of optimization prowess which rivals even the best C code? Yes. But, I’d be a fool to say that it is my cup of tea.Without further discussion of my failings related to software optimization, analysis and the beast which is .ASM, here is my analysis.

## Assembly Code

lab6: file format elf64-littleaarch64

```
Disassembly of section .init:

00000000004004a0 :
  4004a0:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
  4004a4:       910003fd        mov     x29, sp
  4004a8:       9400005c        bl      400618
  4004ac:       a8c17bfd        ldp     x29, x30, [sp],#16
  4004b0:       d65f03c0        ret

Disassembly of section .plt:

00000000004004c0 <time@plt-0x20>:
  4004c0:       a9bf7bf0        stp     x16, x30, [sp,#-16]!
  4004c4:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  4004c8:       f945be11        ldr     x17, [x16,#2936]
  4004cc:       912de210        add     x16, x16, #0xb78
  4004d0:       d61f0220        br      x17
  4004d4:       d503201f        nop
  4004d8:       d503201f        nop
  4004dc:       d503201f        nop

00000000004004e0 <time@plt>:
  4004e0:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  4004e4:       f945c211        ldr     x17, [x16,#2944]
  4004e8:       912e0210        add     x16, x16, #0xb80
  4004ec:       d61f0220        br      x17

00000000004004f0 <__libc_start_main@plt>:
  4004f0:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  4004f4:       f945c611        ldr     x17, [x16,#2952]
  4004f8:       912e2210        add     x16, x16, #0xb88
  4004fc:       d61f0220        br      x17

0000000000400500 <rand@plt>:
  400500:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  400504:       f945ca11        ldr     x17, [x16,#2960]
  400508:       912e4210        add     x16, x16, #0xb90
  40050c:       d61f0220        br      x17

0000000000400510 <__gmon_start__@plt>:
  400510:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  400514:       f945ce11        ldr     x17, [x16,#2968]
  400518:       912e6210        add     x16, x16, #0xb98
  40051c:       d61f0220        br      x17

0000000000400520 <abort@plt>:
  400520:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  400524:       f945d211        ldr     x17, [x16,#2976]
  400528:       912e8210        add     x16, x16, #0xba0
  40052c:       d61f0220        br      x17

0000000000400530 <srand@plt>:
  400530:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  400534:       f945d611        ldr     x17, [x16,#2984]
  400538:       912ea210        add     x16, x16, #0xba8
  40053c:       d61f0220        br      x17

0000000000400540 <printf@plt>:
  400540:       90000090        adrp    x16, 410000 <__FRAME_END__+0xf698>
  400544:       f945da11        ldr     x17, [x16,#2992]
  400548:       912ec210        add     x16, x16, #0xbb0
  40054c:       d61f0220        br      x17

Disassembly of section .text:

0000000000400550 :
  400550:       a9bc7bfd        stp     x29, x30, [sp,#-64]!            # Store array A as a pair in x29, x30
  400554:       910003fd        mov     x29, sp                         # Store begining of the array
  400558:       9100e3a0        add     x0, x29, #0x38                  # Load X0 with X29 + #x38
  40055c:       a9025bf5        stp     x21, x22, [sp,#32]              # Store array B as a pair in x21, x22
  400560:       a90153f3        stp     x19, x20, [sp,#16]              # Store array C as a pair in x19, x20
  400564:       97ffffdf        bl      4004e0 <time@plt>               # Call time@plt branch (argument for srand in c)
  400568:       97fffff2        bl      400530 <srand@plt>              # Call srand@plt branch (init srand in c)
  40056c:       52807d13        mov     w19, #0x3e8                     # MAX defined value from #0x3e8 (1000) into w19
  400570:       d2800015        mov     x21, #0x0                       # Init of int i to 0, stored into x21
  400574:       52800156        mov     w22, #0xa

  // Loop Starts: Fill Array A, B, with Random Numbers
  400578:       97ffffe2        bl      400500 <rand@plt>               # Call rand@plt branch
  40057c:       2a0003f4        mov     w20, w0                         # Move data from w0 to w20
  400580:       97ffffe0        bl      400500 <rand@plt>               # Call rand@plt branch
  400584:       1ad60e83        sdiv    w3, w20, w22                    # Operation: w3 = w20 / w22
  400588:       1ad60c02        sdiv    w2, w0, w22                     # Operation: w2 = w0 / w22

  40058c:       0b030863        add     w3, w3, w3, lsl #2              # Operation: w3 = w3 + shift(w3, left-shift offset by 2)
  400590:       0b020842        add     w2, w2, w2, lsl #2              # Operation: w2 = w20 + shift(w3, left-shift offset by 2)
  400594:       4b030694        sub     w20, w20, w3, lsl #1            # Operation: w20 = 20 - shift(w3, left-shift offset by 1)
  400598:       4b020400        sub     w0, w0, w2, lsl #1              # Operation: w0 = w0 - shift(w3, left-shift offset by 1)
  40059c:       0b000280        add     w0, w20, w0                     # Operation: w0 = w20 + w0 (Result += c[i])
  4005a0:       71000673        subs    w19, w19, #0x1                  # Opeartion: w19 = 19 - #0x1 W/ Flag Set
  4005a4:       8b20c2b5        add     x21, x21, w0, sxtw              # Operation: x21 = x21 + shift(w0, sign extract 64-bit)
  4005a8:       54fffe81        b.ne    400578 <main+0x28>
  // End of Loop

  // Print Final Result
  4005ac:       90000000        adrp    x0, 400000         # Calculation of address x0 access to  memory
  4005b0:       aa1503e1        mov     x1, x21                         # Move data from x21 into x1
  4005b4:       911f4000        add     x0, x0, #0x7d0                  # Operation: x0 = x0 + #0x7d0
  4005b8:       97ffffe2        bl      400540 <printf@plt>             # Call: printf@plt
  4005bc:       2a1303e0        mov     w0, w19                         # Move data from w19 into w0
  4005c0:       a9425bf5        ldp     x21, x22, [sp,#32]              # Load Pair x21, x22 into sp #32
  4005c4:       a94153f3        ldp     x19, x20, [sp,#16]              # Load pair x19, x20 into sp #16
  4005c8:       a8c47bfd        ldp     x29, x30, [sp],#64              # Load pair x29, x30 into sp #64
  4005cc:       d65f03c0        ret                                     # Return (Exit)

00000000004005d0 :
  4005d0:       d280001d        mov     x29, #0x0                       // #0
  4005d4:       d280001e        mov     x30, #0x0                       // #0
  4005d8:       910003fd        mov     x29, sp
  4005dc:       aa0003e5        mov     x5, x0
  4005e0:       f94003e1        ldr     x1, [sp]
  4005e4:       910023e2        add     x2, sp, #0x8
  4005e8:       910003e6        mov     x6, sp
  4005ec:       580000a0        ldr     x0, 400600 <_start+0x30>
  4005f0:       580000c3        ldr     x3, 400608 <_start+0x38>
  4005f4:       580000e4        ldr     x4, 400610 <_start+0x40>
  4005f8:       97ffffbe        bl      4004f0 <__libc_start_main@plt>
  4005fc:       97ffffc9        bl      400520 <abort@plt>
  400600:       00400550        .word   0x00400550
  400604:       00000000        .word   0x00000000
  400608:       00400730        .word   0x00400730
  40060c:       00000000        .word   0x00000000
  400610:       004007a8        .word   0x004007a8
  400614:       00000000        .word   0x00000000

0000000000400618 :
  400618:       90000080        adrp    x0, 410000 <__FRAME_END__+0xf698>
  40061c:       f945b000        ldr     x0, [x0,#2912]
  400620:       b4000040        cbz     x0, 400628 <call_weak_fn+0x10>
  400624:       17ffffbb        b       400510 <__gmon_start__@plt>
  400628:       d65f03c0        ret
  40062c:       00000000        .inst   0x00000000 ; undefined

0000000000400630 :
  400630:       90000081        adrp    x1, 410000 <__FRAME_END__+0xf698>
  400634:       90000080        adrp    x0, 410000 <__FRAME_END__+0xf698>
  400638:       912f0021        add     x1, x1, #0xbc0
  40063c:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
  400640:       912f0000        add     x0, x0, #0xbc0
  400644:       91001c21        add     x1, x1, #0x7
  400648:       910003fd        mov     x29, sp
  40064c:       cb000021        sub     x1, x1, x0
  400650:       f100383f        cmp     x1, #0xe
  400654:       54000068        b.hi    400660 <deregister_tm_clones+0x30>
  400658:       a8c17bfd        ldp     x29, x30, [sp],#16
  40065c:       d65f03c0        ret
  400660:       58000081        ldr     x1, 400670 <deregister_tm_clones+0x40>
  400664:       b4ffffa1        cbz     x1, 400658 <deregister_tm_clones+0x28>
  400668:       d63f0020        blr     x1
  40066c:       17fffffb        b       400658 <deregister_tm_clones+0x28>
        ...

0000000000400678 :
  400678:       90000080        adrp    x0, 410000 <__FRAME_END__+0xf698>
  40067c:       90000081        adrp    x1, 410000 <__FRAME_END__+0xf698>
  400680:       912f0000        add     x0, x0, #0xbc0
  400684:       912f0021        add     x1, x1, #0xbc0
  400688:       cb000021        sub     x1, x1, x0
  40068c:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
  400690:       9343fc21        asr     x1, x1, #3
  400694:       910003fd        mov     x29, sp
  400698:       8b41fc21        add     x1, x1, x1, lsr #63
  40069c:       9341fc21        asr     x1, x1, #1
  4006a0:       b5000061        cbnz    x1, 4006ac <register_tm_clones+0x34>
  4006a4:       a8c17bfd        ldp     x29, x30, [sp],#16
  4006a8:       d65f03c0        ret
  4006ac:       580000a2        ldr     x2, 4006c0 <register_tm_clones+0x48>
  4006b0:       b4ffffa2        cbz     x2, 4006a4 <register_tm_clones+0x2c>
  4006b4:       d63f0040        blr     x2
  4006b8:       17fffffb        b       4006a4 <register_tm_clones+0x2c>
  4006bc:       d503201f        nop
        ...

00000000004006c8 :
  4006c8:       a9be7bfd        stp     x29, x30, [sp,#-32]!
  4006cc:       910003fd        mov     x29, sp
  4006d0:       f9000bf3        str     x19, [sp,#16]
  4006d4:       90000093        adrp    x19, 410000 <__FRAME_END__+0xf698>
  4006d8:       396ef260        ldrb    w0, [x19,#3004]
  4006dc:       35000080        cbnz    w0, 4006ec <__do_global_dtors_aux+0x24>
  4006e0:       97ffffd4        bl      400630
  4006e4:       52800020        mov     w0, #0x1                        // #1
  4006e8:       392ef260        strb    w0, [x19,#3004]
  4006ec:       f9400bf3        ldr     x19, [sp,#16]
  4006f0:       a8c27bfd        ldp     x29, x30, [sp],#32
  4006f4:       d65f03c0        ret

00000000004006f8 :
  4006f8:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
  4006fc:       910003fd        mov     x29, sp
  400700:       90000080        adrp    x0, 410000 <__FRAME_END__+0xf698>
  400704:       f944c001        ldr     x1, [x0,#2432]
  400708:       91260000        add     x0, x0, #0x980
  40070c:       b4000081        cbz     x1, 40071c <frame_dummy+0x24>
  400710:       580000c1        ldr     x1, 400728 <frame_dummy+0x30>
  400714:       b4000041        cbz     x1, 40071c <frame_dummy+0x24>
  400718:       d63f0020        blr     x1
  40071c:       a8c17bfd        ldp     x29, x30, [sp],#16
  400720:       17ffffd6        b       400678
  400724:       d503201f        nop
        ...

0000000000400730 :
  400730:       a9bc7bfd        stp     x29, x30, [sp,#-64]!
  400734:       910003fd        mov     x29, sp
  400738:       a90153f3        stp     x19, x20, [sp,#16]
  40073c:       a90363f7        stp     x23, x24, [sp,#48]
  400740:       90000094        adrp    x20, 410000 <__FRAME_END__+0xf698>
  400744:       90000098        adrp    x24, 410000 <__FRAME_END__+0xf698>
  400748:       9125c318        add     x24, x24, #0x970
  40074c:       9125e294        add     x20, x20, #0x978
  400750:       cb180294        sub     x20, x20, x24
  400754:       9343fe94        asr     x20, x20, #3
  400758:       a9025bf5        stp     x21, x22, [sp,#32]
  40075c:       2a0003f7        mov     w23, w0
  400760:       aa0103f6        mov     x22, x1
  400764:       aa0203f5        mov     x21, x2
  400768:       d2800013        mov     x19, #0x0                       // #0
  40076c:       97ffff4d        bl      4004a0
  400770:       b4000134        cbz     x20, 400794 <__libc_csu_init+0x64>
  400774:       f8737b03        ldr     x3, [x24,x19,lsl #3]
  400778:       2a1703e0        mov     w0, w23
  40077c:       aa1603e1        mov     x1, x22
  400780:       aa1503e2        mov     x2, x21
  400784:       d63f0060        blr     x3
  400788:       91000673        add     x19, x19, #0x1
  40078c:       eb14027f        cmp     x19, x20
  400790:       54ffff21        b.ne    400774 <__libc_csu_init+0x44>
  400794:       a94153f3        ldp     x19, x20, [sp,#16]
  400798:       a9425bf5        ldp     x21, x22, [sp,#32]
  40079c:       a94363f7        ldp     x23, x24, [sp,#48]
  4007a0:       a8c47bfd        ldp     x29, x30, [sp],#64
  4007a4:       d65f03c0        ret

00000000004007a8 :
  4007a8:       d65f03c0        ret

Disassembly of section .fini:

00000000004007ac :
  4007ac:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
  4007b0:       910003fd        mov     x29, sp
  4007b4:       a8c17bfd        ldp     x29, x30, [sp],#16
  4007b8:       d65f03c0        ret
```

## Thoughts

It seems based on my analysis, that a pivotal operation is the storing of variables into the registers as pairs, utilizing STP for said operation. This then allows for iterations between 8 elements of the array at a time. How the compiler is choosing to vectorized is still beyond me, but that’s what the lesson is for? Right?. Regardless, I can understand basic Assembly which puts me further knowledge wise than I was in the previous weeks.

# Step 4

Without modifying the previous lab’s code to utilize the auto vectorized features of the compiler, along with inline-assembly code for further optimizations, here are some thoughts which were collected upon reviewing with peers their ideas along with my own.

1. Utilize DUP to duplicate the volume factor into a scalar vector register. Wikipedia describes scalar registers as follows:

   > A scalar processor processes only one datum at a time, with typical data items being [integers](https://en.wikipedia.org/wiki/Integer_%28computer_science%29) or [floating point numbers](https://en.wikipedia.org/wiki/Floating_point_number)). A scalar processor is classified as a [SISD](https://en.wikipedia.org/wiki/SISD) processor (Single Instructions, Single Data) in [Flynn's taxonomy](https://en.wikipedia.org/wiki/Flynn%27s_taxonomy).

2. Store the ‘Sample’ Data into a register using LD1. LD1 is an instruction which loads multiple 1-element structures into a vector register.
