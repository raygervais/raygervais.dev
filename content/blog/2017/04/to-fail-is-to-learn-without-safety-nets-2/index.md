---
title: "To Fail, is to Learn Without Safety Nets 2"
date: 2017-04-10
draft: false
tags: ["Open Source", "Seneca", "SPO600"]
description: "The reason for such debauchery of our beloved cryptographic function? Because in attempts to optimize; I did the polar opposite. Coming to terms with such a fact is a difficult endeavour; analysing why it couldn’t be any more optimized being the only solution at the present time. So, I’ll continue from where I left off on!"
---

_An SPO600 Project Update & Admittance to Failure_

Part 2

In my previous [blog post](http://raygervais.ca/to-fail-is-to-learn-without-safety-nets/), I dissected the first half of the SHA512.c implementation found in the GNU Standard C Library. The reason for such debauchery of our beloved cryptographic function? Because in attempts to optimize; I did the polar opposite. Coming to terms with such a fact is a difficult endeavour; analysing why it couldn’t be any more optimized being the only solution at the present time. So, I’ll continue from where I left off on!

# Line 166: void \_\_sha512_process_bytes (const void *buffer, size_t len, struct sha512_ctx *ctx)

This function is called from the the external `sha512-crypt.c` file, which is a correction to my previous assumption blog post which claimed this function being called in the previously analysed source code. Instead, I’ll keep analyzing and perhaps venture into other files if time permits in follow up posts. No promises on the later statement.

The first code block is only executed if the ctx->buflen’s value is not equal to 0. The comment above gives a hint as to why we have this conditional check before processing, which is “When we already have some bits in our internal buffer concatenate both inputs first”. The first code block’s logic is as follows:

- Assign the value of ctx->buflen to a size_t variable titled “left_over”.
- Create a size_t variable titled “add” which is the value assigned by a ternary operation `256 - left_over > len ? len : 256 - left_over`.
- Perform a memcpy on ctx’s buffer at the left_over array index, using arguments buffer and add as well.
- If the above condition resolves to true, \_\_sha512_process_block is called, and then memcpy is called again with multiple arguments from ctx.
- After that condition, the buffer is assigned to a casted const char pointer sum of buffer and add. Finally add’s value is subtracted from len. Completes the code block.
- Assign the sum of ctx’s buflen and add to ctx’s buflen. This is then tested against a condition seeing if ctx’s buflen is greater than 128.

The next code block process the complete blocks according to the comments, with a condition checking to see if the argument len is greater than or equal to 128. The next few lines determine how a function titled UNALIGNED_P(p) should be defined, dictated by the GNUC version.

Line 205 describes a while loop which processes the buffer variable in 128 bytes at a time  it appears. The last code block moves the remaining bytes into the internal buffer.

## Analysis

Going back to my original statement in part 1, it appears that if the defined SWAP algorithm could be optimized the entire process would see a performance increase. Likewise, in this entire area of functions relating to cryptography,  it seems to me that memcpy could be the potential bottleneck; It is called six times throughout the file, often in loops. Another student is optimizing I believe, but I could be wrong.

Looking into the while loop above, making the buffer be processed in 256 bytes at a time may be possible, but the logic would have to change to accommodate the expanded byte range. Furthermore, because this is cryptography I’m too uncertain to experiment with such modification of logic.

Had I started sooner perhaps, delegated more time, or even just had more time to truly focus on the other items related to SHA512 cryptographic, perhaps I would have found a sane way to optimize the functions through inline assembly or a complete rewrite.

# Tests & Ideas

Below are some code snippets that I came up with while testing theories and possible optimizations. Note that as you’ll see, most are minor optimizations in this case, meant to prove that the optimizations of this function lies solely with memcpy. As I go around reviewing this post, I see that the only optimizations possible were small ones which removed an addition operator. This code is highly optimized it seems.

## Line 147:

**Replace**

pad = bytes >= 112 ? 128 + 112 - bytes : 112 - bytes;

With

pad = bytes >= 112 ? 240 - bytes : 112 - bytes;

# Conclusion

A good majority of the lack of optimizations were my own fault, the primary factor being a horrible sense of taste when it comes to choosing functions to optimize. The later, being that perhaps I did not put enough effort into this project, prioritising other projects much more in comparison. My previous function for example, segfault, contained much more potential for optimization. The better question, was what good would such optimizations do? In the end, it's all a learning experience, and I'm glad that I was given the chance.
