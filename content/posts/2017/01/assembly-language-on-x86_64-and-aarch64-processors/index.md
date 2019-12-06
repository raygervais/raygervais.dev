---
title: "Assembly Language on x86_64 and aarch64 processors"
date: "2017-01-26"
---

SPO600 Week 2 Deliverable

Assembly language, a low level programming language which enables deeper integration with the supported machine’s architecture. An Assembly file is converted to machine code by using an assembler, which is a utility that converts the source code to binary. By utilizing Assembly, one has access to the respective register, flags, and memory operations of a CPU processor. These components differ by architecture, where aarch64 follows a different set of processor rule sets such as having a larger set of registers capable of floating point and data instructions, and different operation syntax.

For our introduction to programming Assembly for both architectures, groups of students were given a specific task. The program should loop a maximum of thirty times, while doing so printing the iteration of said loop to the screen. The implementations for both are linked to this blog post for those curious, both in binary and source code formats.

For the first few hours, Assembly seemed less like a comprehensible language and more like the ‘hell’ that many claim php to be. It took a while for the understanding to present itself just for the basic loop portion, let alone why we add the .data related variables into the correct registers for outputting. But, after quite a few tutorials both in person and through YouTube, I can safely say that I can read a hello world written in Assembly.

[aarch64 Files](http://raygervais.ca/wp-content/uploads/2017/01/ARM.tar.gz)

[x86\_64 Files](http://raygervais.ca/wp-content/uploads/2017/01/X64.tar.gz)
