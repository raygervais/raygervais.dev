---
title: "Reviewing a Peer's Optimization"
date: 2017-04-17
draft: false
tags: ["Open Source", "Seneca", "SPO600"]
description: "This post will be one of my last related to this semester, specifically to OSD600 which has seen the class learning quite a bit about Open Source web technologies; contributing to Mozilla’s Thimble in doing so."
---

_A Code Review Summary for SPO600_

For the final project of the Software Portability Course, the class was tasked with reviewing the code of a peer who’d set up a pull request for Chris’ GLIBC repository. For my code review, I decided my good friend [John](https://github.com/johnejames) would be a worthy candidate for my review musings, his pull request being found [here](https://github.com/ctyler/spo600-glibc/pull/3) for those interested in viewing.

There were a few stylistic issues that I brought up, all of which a simple fix would remedy.

## The Code

```c
/* Copyright (C) 1991-2017 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#include <string.h>
#include <stdint.h>
#include <libc-pointer-arith.h>

#undef strcspn

#ifndef STRCSPN
# define STRCSPN strcspn
#endif

/* Return the length of the maximum initial segment of S
   which contains no characters from REJECT.  */
size_t STRCSPN (const char *str, const char *reject)
{
  if (__glibc_unlikely (reject[0] == '\\0') ||
      __glibc_unlikely (reject[1] == '\\0'))
    return __strchrnul (str, reject [0]) - str;

  /* Use multiple small memsets to enable inlining on most targets.  */
  unsigned char table[256];
  unsigned char *p = memset(table, 0, 64);
  memset(p + 64, 0, 64);
  memset(p + 128, 0, 64);
  memset(p + 192, 0, 64);

  unsigned char *s = (unsigned char*)reject;
  unsigned char tmp;
  do
    p[tmp = *s++] = 1;
  while (tmp);

  s = (unsigned char*)str;
  if (p[s[0]]) return 0;
  if (p[s[1]]) return 1;
  if (p[s[2]]) return 2;
  if (p[s[3]]) return 3;
  if (p[s[4]]) return 4;
  if (p[s[5]]) return 5;
  if (p[s[6]]) return 6;
  if (p[s[7]]) return 7;

  unsigned int c0, c1, c2, c3, c4, c5, c6, c7;
  do
  {
    s += 8;
    c0 = p[s[0]];
    c1 = p[s[1]];
    c2 = p[s[2]];
    c3 = p[s[3]];
    c4 = p[s[4]];
    c5 = p[s[5]];
    c6 = p[s[6]];
    c7 = p[s[7]];
  } while ((c0 | c1 | c2 | c3 | c4 | c5 | c6 | c7) == 0);

  size_t count = s - (unsigned char *)str;

  if (c0 | c1 != 0) {
    return count - c0 + 1;
  }
  else if ((c2 | c3) != 0) {
    return count - c2 + 3;
  }
  else if ((c4 | c5) != 0) {
    return count - c4 + 5;
  }
  else {
    return count - c6 + 5;
  }

}
libc_hidden_builtin_def (strcspn)
```

## The Stylistic Issues In Question

Throughout the GLIBC, a common coding convention can be found throughout the familiar and obscure files. In such convention, is the inclusion of a space between the function name and arguments. John’s editor perhaps did not detect this, and instead replaced all of his code with the common function sans-space argument arrangement.

As you can see below, the issue is a minor one which is easily overlooked.

### Coding Convention Issue #1: Correct

`memset (p + 64, 0, 64);`

### Coding Convention Issue #1: Incorrect

`memset(p + 64, 0, 64);`

Another convention issue, was the rearranging of declaration syntax for variables and functions. I won’t deny, the GLIBC’s coding style is unfamiliar to someone who’s experience with C derives from few courses, and I did question why that style of C syntax was deemed essential for the time. Perhaps to reduce line length? This idea does make sense on the low-resolution terminals utilized in the days of old, but does look rather odd to the modern programmer.

## Coding Convention Issue #2: Correct

```c
size_t
STRCSPN (const char *str, const char *reject)
```

### Coding Convention Issue #2: Incorrect

`size_t STRCSPN (const char *str, const char *reject)`

## Conclusion

John’s optimizations enable support for 64-bit processing, which is a big improvement to modern servers & programs alike. Having gone through his code modifications for the review, I did not see any issues regarding logic or operations, which in the end will always be the make-it / break-it factor. He did damn good work with the optimization, and with the stylistic change I’ve mentioned above, I think the upstream developers will accept his code contribution without hesitation.
