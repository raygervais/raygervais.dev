---
title: "Algorithm Selection in C"
date: "2017-02-17"
---

SPO600 Week Five Deliverables

During this lab, we were instructed to program two different implementations which attempted the same process; adjusting the volume of a sequence of samples. This program would be implemented in C, and benchmarked using the conventional time.h library available through the system.

# Implementation One

This simple implementation utilized the following function, which I’ve included below this description.

struct Result sum\_naive(){
        size\_t i;
        struct Result res;
        int16\_t val;

        gettimeofday(&res.time\_start, NULL);
        res.sum = 0;
        for(i = 0; i < SIZE; i++){
                val = data\[i\] \* VOL;
                output\[i\] = val;
                res.sum += val;
        }
        gettimeofday(&res.time\_end, NULL);

        return res;
}

This simple algorithm did all calculations, and assignments in a for statement which would loop the defined ‘SIZE’ amount of times. SIZE was defined at the time of this post as 500,000,000. The first issue we saw was multiple assignment operators during the loop, which would have an impact on performance that make up a second of the entire runtime.

# Implementation Two

struct Result sum\_custom() {
        int i;
        struct Result res;
        int16\_t table\[0xFFFF\];
        int idx;

        gettimeofday(&res.time\_start, NULL);
        res.sum = 0;
        for(i = -32767; i <=32767;i++){
                table\[i & 0xFFFF\] = i \* VOL;
        }

        int sz = SIZE;
        for(i = 0; i < sz ; i++){
                idx = (unsigned short) data\[i\];
                res.sum += output\[i\] = table\[idx\];
                res.sum += output\[i\] = table\[(unsigned short) data\[i++\]\];
                res.sum += output\[i\] = table\[(unsigned short) data\[i++\]\];
                res.sum += output\[i\] = table\[(unsigned short) data\[i++\]\];
                res.sum += output\[i\] = table\[(unsigned short) data\[i++\]\];

                res.sum += table\[data\[i++\] & 0xFFFF\]
                        + table\[data\[i++\] & 0xFFFF\]
                        + table\[data\[i\] & 0xFFFF\];

        }

        gettimeofday(&res.time\_end, NULL);
        return res;
}

This implementation on the other hand utilized calculations outside of the for statement, effectively reducing the amount of multiplication calls to 65,335 in contrast to the original 500,000,000. This, along with the removal of a line used in the first implementation which negated the compiler from optimizing the entire loop ensured that our second implementation would be much more performant than the previous.

# Observations and Analysis

On the AArch64 server, the following code functions each ran with the same input data, and reported the following data metric:

Naive: 5.616 Seconds

Custom: 2.285 Seconds

Time Difference: 3.331 Seconds

In contrast, to the x86\_64 server the following data metrics were provided at the end of the application execution:

Naive:2.984 Seconds

Custom: 1.173 Second

Time Difference: 1.811 Seconds

With the above results, upon investigating each executables machine code and attempting optimizations on that level, the AArch64 server was the one which benefited the most from the optimizations. This was discovered after using the -O3 GCC argument, which would create the most optimal executable it could. This in contrast, did not have too much benefit on the X86\_64 server which by default optimized much more of the code logic from the very start, making only subtle changes to the runtime of the program.
