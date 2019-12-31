---
title: "Optimizing Glibc’s SegFault"
date: 2017-03-19
published: true
tags: ["Open Source", "Seneca", "SPO600"]
description: "Segmentation Fault (Core Dumped) is a phrase that many know all too well, so much so that some developers such as yours truly was even granted the pleasurable nickname of ‘segfault’ during their first year at Seneca College. So, when tasked with the intention of optimizing a function or few from the GNU C Library (GLibc for short), I thought I may as well play a hand in ruining other programmer’s days as well. Seeing that segfault() existed in this library lit up my eyes to mischievous intents and melancholy memories, but I knew I wanted to take a crack at improving it."
---

_SPO600 Project Specifications and Concepts_

Segmentation Fault (Core Dumped) is a phrase that many know all too well, so much so that some developers such as yours truly was even granted the pleasurable nickname of ‘segfault’ during their first year at Seneca College. So, when tasked with the intention of optimizing a function or few from the GNU C Library (GLibc for short), I thought I may as well play a hand in ruining other programmer’s days as well. Seeing that segfault() existed in this library lit up my eyes to mischievous intents and melancholy memories, but I knew I wanted to take a crack at improving it.

## Diving Into the Code

Cracking open the segfault.c file located in the debug folder with Vim introduced me to a 210 lined source code which included many define-styled tags and includes. After looking over the license and setup (includes, defines), was some of the most amazing code I had read in the past month. Equally readable, to the point and robust, I was impressed with what this offered compared to many other functions I had looked into which though not horribly written, was not human-friendly in any way. A great example of such code is the very first function written, which looks like the following:

```c
* We better should not use 'strerror' since it can call far too many
   other functions which might fail.  Do it here ourselves.  */
static void
write_strsignal (int fd, int signal)
{
  if (signal < 0 || signal >= _NSIG || _sys_siglist[signal] == NULL)
    {
      char buf[30];
      char *ptr = _itoa_word (signal, &buf[sizeof (buf)], 10, 0);
      WRITE_STRING ("signal ");
      write (fd, buf, &buf[sizeof (buf)] - ptr);
    }
  else
    WRITE_STRING (_sys_siglist[signal]);
}
```
This function does not look like any optimizations can be applied which would benefit it beyond what is already there. Instead, I think a function which has much more potential for optimizations is the following:

```c
* This function is called when a segmentation fault is caught.  
 The system is in an unstable state now.  
 This means especially that malloc() might not work anymore.  */
static void
catch_segfault (int signal, SIGCONTEXT ctx)
{
  int fd, cnt, i;
  void **arr;
  struct sigaction sa;
  uintptr_t pc;

  /* This is the name of the file we are writing to.  If none is given
     or we cannot write to this file write to stderr.  */
  fd = 2;
  if (fname != NULL)
    {
      fd = open (fname, O_TRUNC | O_WRONLY | O_CREAT, 0666);
      if (fd == -1)
    fd = 2;
    }

  WRITE_STRING ("*** ");
  write_strsignal (fd, signal);
  WRITE_STRING ("\n");

#ifdef REGISTER_DUMP
  REGISTER_DUMP;
#endif

  WRITE_STRING ("\nBacktrace:\n");

  * Get the backtrace.  */
  arr = alloca (256 * sizeof (void *));
  cnt = backtrace (arr, 256);

  * Now try to locate the PC from signal context in the backtrace.
     Normally it will be found at arr[2], but it might appear later
     if there were some signal handler wrappers.  Allow a few bytes
     difference to cope with as many arches as possible.  */
  pc = (uintptr_t) GET_PC (ctx);
  for (i = 0; i < cnt; ++i)
    if ((uintptr_t) arr[i] >= pc - 16 && (uintptr_t) arr[i] <= pc + 16)
      break;

  /* If we haven't found it, better dump full backtrace even including
     the signal handler frames instead of not dumping anything.  */
  if (i == cnt)
    i = 0;

  /* Now generate nicely formatted output.  */
  __backtrace_symbols_fd (arr + i, cnt - i, fd);

#ifdef HAVE_PROC_SELF
  /* Now the link map.  */
  int mapfd = open ("/proc/self/maps", O_RDONLY);
  if (mapfd != -1)
    {
      write (fd, "\nMemory map:\n\n", 14);

      char buf[256];
      ssize_t n;

      while ((n = TEMP_FAILURE_RETRY (read (mapfd, buf, sizeof (buf)))) > 0)
    TEMP_FAILURE_RETRY (write (fd, buf, n));

      close (mapfd);
    }
#endif

  /* Pass on the signal (so that a core file is produced).  */
  sa.sa_handler = SIG_DFL;
  sigemptyset (&sa.sa_mask);
  sa.sa_flags = 0;
  sigaction (signal, &sa, NULL);
  raise (signal);
}
```

## Optimization Ideas

Below are some of my notes, and observations which may lead to optimizations that may benefit the function. Further research will have to be conducted before I could attempt to improve the codebase, for segfault.c suffers similar faults as much of the functions, highly optimized programming.

### Loop Unrolling

- Line# 109 of ~/debug/segfault.c: PC calculations can occur before the loop itself.

### Loop / Variable Unswitching

- Line# 152 of ~/debug/segfault.c: *name is not used till line 185.
- Line# 74 of ~/debug/segfault.c: i is not used till line 108.

These are minor optimizations, and as I discover more I’ll append them to the next blog post which covers this topic, backward-linking to this post.
