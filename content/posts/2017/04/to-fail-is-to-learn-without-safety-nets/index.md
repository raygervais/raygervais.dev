---
title: "To Fail, is to Learn Without Safety Nets"
date: 2017-04-04
published: true
tags: ["Open Source", "Seneca", "SPO600"]
description: "This series of posts includes not just my admittance to failure, unable to optimize a previously selected function, but also how I learned from said failure in regards to style, logic, and also why the algorithm was already at peak performance."
---

_An SPO600 Project Update & Admittance to Failure_

Part 1

## Introduction

This series of posts includes not just my admittance to failure, unable to optimize a previously selected function, but also how I learned from said failure in regards to style, logic, and also why the algorithm was already at peak performance.  The catalyst to this downward spiral can be found in my previous [blog post](http://raygervais.ca/when-segfaulting-wont-do/), which described my first dance with unnecessary optimizations to the segfault handler in the GLibC library.  My alternative function that I had chosen was the cryptography celebrity, SHA512, which I will discuss more in detail below. After each analytical paragraph, will be an analysis as to why the that section of the SHA512 implementation in the GNU Standard C Library is already well optimized beyond what my capabilities can contribute to.

## SHA512 Analysis

For those who have a copy of the GLIBC on hand, or wish to view the code on a [mirrored repository](https://github.com/ctyler/ops600-glibc) to follow along, the location of the SHA512 implementation is ~/crypt/sha512.c. The last recorded code change (that is, ignoring copyright or license updates), was [five months ago](https://github.com/ctyler/ops600-glibc/blame/master/crypt/sha512.c), which simply adjusted the names of the internal functions to a new standard.

### Line 34: #if **BYTE_ORDER == **LITTLE_ENDIAN

This is the first logical segment after the C-styled includes of the endian, stdlib, string, stdint, sys/types, and sha512 header files, and to understand the first condition, a definition is needed to for Little Endian vs Big Endian, and the overall concept of Endianness.

#### Endianness

Wikipedia’s [entry](https://en.wikipedia.org/wiki/Endianness) on the topic is very thorough, so I’ve included it’s summary which explains Endianness well:

Endianness refers to the sequential order used to numerically interpret a range of [bytes](https://en.wikipedia.org/wiki/Byte) in [computer memory](https://en.wikipedia.org/wiki/Computer_memory) as a larger, composed [word](https://en.wikipedia.org/wiki/Word_%28data_type%29) value. It also describes the order of byte transmission over a digital link. Words may be represented in **big-endian** or **little-endian** format, with the term "end" denoting the front end or start of the word, a nomenclature potentially [counterintuitive](https://en.wikipedia.org/wiki/Counterintuitive) given the connotation of "finish" or "final portion" associated with "end" as a stand-alone term in everyday language.

#### Big Endian

This format stores the greatest value’s most significant bit in  the smallest possible address, with the following most significant byte preceding. The image to the side provided by Wikipedia describes how a 32-bit integer would be stored in Big Endian format, with an example from the [University of Maryland](https://www.cs.umd.edu/class/sum2003/cmsc311/Notes/Data/endian.html) providing an example using 4 bytes of data; each byte requiring 2 hexadecimal digits.

If given the following data: **90, AB, 12, CD**, Big Endian would store the data in the following manner:

**Address Value**

1000    90
1001    AB
1002    12
1003    CD

### Little Endian

This format follows the opposite of Big Endian, storing the least significant byte in the smallest address. Using the same example from the University of Maryland, which better explains the diagram provided by Wikipedia, you’d have the following allocation:

**Address Value**

1000    CD
1001    12
1002    AB
1003    90

### Line 35: _LIBC

This code block is checking for LIBC, which is the compiled library. If it does exist, then we include the byteswap header file, and define SWAP(n) as bswap_64(n). If this we do not register the LIBC definition, then SWAP is defined using the following code sequence:

#  define SWAP(n) \\
(((n) << 56)                   \\
| (((n) & 0xff00) << 40)           \\
| (((n) & 0xff0000) << 24)           \\
| (((n) & 0xff000000) << 8)           \\
| (((n) >> 8) & 0xff000000)           \\
| (((n) >> 24) & 0xff0000)           \\
| (((n) >> 40) & 0xff00)           \\
| ((n) >> 56))

# endif

Since LIBC is included 90% of the time, I think this is for the edge-case where someone compiled the crypt utilities alone. The final two lines of this function are the edge case where _BYTE_ORDER is equivalent to __BIG_ENDIAN, in which case the SWAP is defined as  SWAP(n) (n).

### Optimization Analysis

I do not see any optimizations possible here, which is due to the overall simplicity of the function. In consequence to understanding this code segment, I looked into the a great [article](https://www.anintegratedworld.com/masking-bit-shifting-and-0xff00/) which explains the syntax and concept behind bit masking. The bit masking allows for rearranging of the bytes themselves in a very efficient manner.

### Line 131: void * __sha512_finish_ctx (struct sha512_ctx *ctx, void \*resbuf)

This is the first function which contains logic, with the previous functions initializing array variables with constants and buffers. The function itself follows this logic, which I’ll explain why is already at peak performance code-wise after:

1. Take into account unprocessed bytes by creating a `uint64_t` variable which contains `ctx->buflen`. It’s named bytes in this case.
2. Create a size_t variable called pad, which will be used later.
3. If the USE_TOTAL128, add ctx->total128 and the bytes variable created previously, if not, we add bytes above to the array in ctx called total. The last step, if the value we just added together in the array being smaller than the variable in step 1, is to increment the total array at TOTAL128_high by one.
4. Here, we make pad equal to one of two conditions, based on bytes being greater or equivalent to 112. The first, is pad getting the difference of the bytes variable, and 240, the later being the difference of bytes and 112.
5. Line’s 151 & 152 describe putting the 128-bit file length in _bits_ at the end of the buffer, doing so using the defined SWAP function. The process looks like this:

ctx->buffer64[(bytes + pad + 8) / 8] = SWAP (ctx->total[TOTAL128_low] << 3);
ctx->buffer64[(bytes + pad) / 8] = SWAP ((ctx->total[TOTAL128_high] << 3) |
(ctx->total[TOTAL128_low] >> 61));

1. This step processes the last bytes, calling _sha512_process_block which will be explained in the next segment.
2. Finally, a for loop iterates through an uint64_t array called resbuf, assigning the index to the value of the defined SWAP function with ctx’s H array at the same index.
3. Return resbuf.

#### Optimization Analysis

A minuscule difference, is that currently the variable pad which is defined on line 136 is never used or initialized until line 147. The operations which take place in the 11 lines between the two are steps 3, which do not interact with the variable in anyway. Moving ‘pad’ to be declared before line 147 could increase compiler optimization potential, hypothetically allowing for the variable to be located horizontally in memory which would enable a lookup performance increase.

Seeing the importance of the predefined SWAP function, optimizing it (if it were possible) would make the greatest difference from my overall analysis so far. These ideas is a concept mind you, meaning that I would not bet anything of value on my thoughts or my contributions just yet. They’re rough, unrefined, ignorant.

## Conclusion

Regardless, the overview is interesting, and also quite enlightening as to how cryptography in this context works, advanced bit management in C, and the coding conventions found throughout the entire Glibc. Though no segfault, no swan-song parody of a program's best state, SHA512 is quite the hot topic as of recent with the technical blogs highlighting recent git collisions discoveries; Linus’ opinion on the matter, and how the industry itself is responding. Observing how SHA512 is implemented in C is not an item that I thought I’d be doing if ever in my programming career, but I’m damn pleased with the chance to do so. Stay tuned for my next segment, which will look over the final function in SHA512.c.
