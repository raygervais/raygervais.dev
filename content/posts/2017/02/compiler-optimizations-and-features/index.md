---
title: "Compiler Optimizations and Features"
date: 2017-02-01
published: true
tags: ["Open Source", "Seneca", "SPO600"]
description: "When we were given the instructions to search, locate and eventually implement fixes or upgrades to Mozilla’s Thimble or Brackets, I found what perhaps was the most challenging enhancement I could possible implement."
---

An Intro, Deliverable Four for SPO600

When compiling projects, files and various utilities, the IDE you use takes care of quite a bit of background tasks, arguments and settings. Some of these settings and arguments can make quite the difference to the end product, relating to performance overhead, file size and included binaries which make up the final file. Exploring this topic, let’s examine some of these arguments and settings related to GCC, which are explained below, using a reference `hello.c` file which contains the following:

```c
#include<stdio.h>
void output(int i);
int main()
{
  printf(“Hello World!”);
  return 0;
}
```

## Arguments

-o Filename

Indicates that you’d like to name the output file as the argument provided, defaulting to a.out in most environments if this argument is not provided.

-g

This enables debugging information

-O0

This indicates to the compiler that you do not want the program’s binary files to be optimized. There are a varying amount of optimizations that can occur to during the compilation of a program, and GCC allows for the a levelled approach to each optimization in the following way:

- O1: This level compiles at a moderate pace, but reduces the code base to the smallest possible level. In doing so, a drawback is the lost of execution speed of the program.
- O2: This level in contrast also compiles at a moderate pace, but only reduces the code footprint by so much, thus enabling a moderate rate of execution speed for the program.
- O3: This level applies the most amount of optimizations to the source, making for slow compiler times but incredibly fast performance time in contrast. This, is due to a much larger file being created at the level which is highly optimized in contrast to the previous two options. This is the only tier which does not provide safety features.
- Os: This level optimizes for code size only, without affecting the performance of the program.
- Ofast: This follows the same optimizations as O3, with none accurate math calculations

\-fno-builtin

This disables the builtin function optimizations found in various compilers. Doing so negates part of the compilers run time functions which would normally generate code to handle a subset of builtin functions more efficiently.

## Effects on the Hello.c Program

The following results were recorded by using

`objdump -f -s -d --sourcefile >> objdump_step_x.txt`

which allows for recording the data into a text document for easier research.

Optimization Used

File Size

Notes

```
-g -O0 -fno-builtin hello.c

23.0KiB

This was the original compilation to be used for the lab

-g -O0 -fno-builtin -static hello.c

9.8MiB

The static argument option links a program statically to any dependencies, implying that the program does not require any dynamic libraries at run time to execute.

-g -O0 hello.c

23.0KiB

Removing the fno-builtin argument allows for the compiler to replace the print call with putchar instead, attempting to optimize the simply program this way.

-O0 hello.c

15.3KiB

Debugging information in the operating systems native format was not produced in this compilation. This reduces the size by 7.7KiB

-O0 hello.c

16.0KiB

Additional lines of code were added to the program, resulting in the the printf function being put inside a for loop, and displaying the current iteration of i.

-O3 hello.ca

17.0KiB

```

Code is vastly more reliant on calls to memory locations in the file, with majority of the objects and variables being stored in registers
