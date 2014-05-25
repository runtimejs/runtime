#define __X32_SYSCALL_BIT        0x40000000
#define __NR_read (__X32_SYSCALL_BIT + 0)
#define __NR_write (__X32_SYSCALL_BIT + 1)
#define __NR_open (__X32_SYSCALL_BIT + 2)
#define __NR_close (__X32_SYSCALL_BIT + 3)
#define __NR_stat (__X32_SYSCALL_BIT + 4)
#define __NR_fstat (__X32_SYSCALL_BIT + 5)
#define __NR_lstat (__X32_SYSCALL_BIT + 6)
#define __NR_poll (__X32_SYSCALL_BIT + 7)
#define __NR_lseek (__X32_SYSCALL_BIT + 8)
#define __NR_mmap (__X32_SYSCALL_BIT + 9)
#define __NR_mprotect (__X32_SYSCALL_BIT + 10)
#define __NR_munmap (__X32_SYSCALL_BIT + 11)
#define __NR_brk (__X32_SYSCALL_BIT + 12)
#define __NR_rt_sigprocmask (__X32_SYSCALL_BIT + 14)
#define __NR_pread64 (__X32_SYSCALL_BIT + 17)
#define __NR_pwrite64 (__X32_SYSCALL_BIT + 18)
#define __NR_access (__X32_SYSCALL_BIT + 21)
#define __NR_pipe (__X32_SYSCALL_BIT + 22)
#define __NR_select (__X32_SYSCALL_BIT + 23)
#define __NR_sched_yield (__X32_SYSCALL_BIT + 24)
#define __NR_mremap (__X32_SYSCALL_BIT + 25)
#define __NR_msync (__X32_SYSCALL_BIT + 26)
#define __NR_mincore (__X32_SYSCALL_BIT + 27)
#define __NR_madvise (__X32_SYSCALL_BIT + 28)
#define __NR_shmget (__X32_SYSCALL_BIT + 29)
#define __NR_shmat (__X32_SYSCALL_BIT + 30)
#define __NR_shmctl (__X32_SYSCALL_BIT + 31)
#define __NR_dup (__X32_SYSCALL_BIT + 32)
#define __NR_dup2 (__X32_SYSCALL_BIT + 33)
#define __NR_pause (__X32_SYSCALL_BIT + 34)
#define __NR_nanosleep (__X32_SYSCALL_BIT + 35)
#define __NR_getitimer (__X32_SYSCALL_BIT + 36)
#define __NR_alarm (__X32_SYSCALL_BIT + 37)
#define __NR_setitimer (__X32_SYSCALL_BIT + 38)
#define __NR_getpid (__X32_SYSCALL_BIT + 39)
#define __NR_sendfile (__X32_SYSCALL_BIT + 40)
#define __NR_socket (__X32_SYSCALL_BIT + 41)
#define __NR_connect (__X32_SYSCALL_BIT + 42)
#define __NR_accept (__X32_SYSCALL_BIT + 43)
#define __NR_sendto (__X32_SYSCALL_BIT + 44)
#define __NR_shutdown (__X32_SYSCALL_BIT + 48)
#define __NR_bind (__X32_SYSCALL_BIT + 49)
#define __NR_listen (__X32_SYSCALL_BIT + 50)
#define __NR_getsockname (__X32_SYSCALL_BIT + 51)
#define __NR_getpeername (__X32_SYSCALL_BIT + 52)
#define __NR_socketpair (__X32_SYSCALL_BIT + 53)
#define __NR_clone (__X32_SYSCALL_BIT + 56)
#define __NR_fork (__X32_SYSCALL_BIT + 57)
#define __NR_vfork (__X32_SYSCALL_BIT + 58)
#define __NR_exit (__X32_SYSCALL_BIT + 60)
#define __NR_wait4 (__X32_SYSCALL_BIT + 61)
#define __NR_kill (__X32_SYSCALL_BIT + 62)
#define __NR_uname (__X32_SYSCALL_BIT + 63)
#define __NR_semget (__X32_SYSCALL_BIT + 64)
#define __NR_semop (__X32_SYSCALL_BIT + 65)
#define __NR_semctl (__X32_SYSCALL_BIT + 66)
#define __NR_shmdt (__X32_SYSCALL_BIT + 67)
#define __NR_msgget (__X32_SYSCALL_BIT + 68)
#define __NR_msgsnd (__X32_SYSCALL_BIT + 69)
#define __NR_msgrcv (__X32_SYSCALL_BIT + 70)
#define __NR_msgctl (__X32_SYSCALL_BIT + 71)
#define __NR_fcntl (__X32_SYSCALL_BIT + 72)
#define __NR_flock (__X32_SYSCALL_BIT + 73)
#define __NR_fsync (__X32_SYSCALL_BIT + 74)
#define __NR_fdatasync (__X32_SYSCALL_BIT + 75)
#define __NR_truncate (__X32_SYSCALL_BIT + 76)
#define __NR_ftruncate (__X32_SYSCALL_BIT + 77)
#define __NR_getdents (__X32_SYSCALL_BIT + 78)
#define __NR_getcwd (__X32_SYSCALL_BIT + 79)
#define __NR_chdir (__X32_SYSCALL_BIT + 80)
#define __NR_fchdir (__X32_SYSCALL_BIT + 81)
#define __NR_rename (__X32_SYSCALL_BIT + 82)
#define __NR_mkdir (__X32_SYSCALL_BIT + 83)
#define __NR_rmdir (__X32_SYSCALL_BIT + 84)
#define __NR_creat (__X32_SYSCALL_BIT + 85)
#define __NR_link (__X32_SYSCALL_BIT + 86)
#define __NR_unlink (__X32_SYSCALL_BIT + 87)
#define __NR_symlink (__X32_SYSCALL_BIT + 88)
#define __NR_readlink (__X32_SYSCALL_BIT + 89)
#define __NR_chmod (__X32_SYSCALL_BIT + 90)
#define __NR_fchmod (__X32_SYSCALL_BIT + 91)
#define __NR_chown (__X32_SYSCALL_BIT + 92)
#define __NR_fchown (__X32_SYSCALL_BIT + 93)
#define __NR_lchown (__X32_SYSCALL_BIT + 94)
#define __NR_umask (__X32_SYSCALL_BIT + 95)
#define __NR_gettimeofday (__X32_SYSCALL_BIT + 96)
#define __NR_getrlimit (__X32_SYSCALL_BIT + 97)
#define __NR_getrusage (__X32_SYSCALL_BIT + 98)
#define __NR_sysinfo (__X32_SYSCALL_BIT + 99)
#define __NR_times (__X32_SYSCALL_BIT + 100)
#define __NR_getuid (__X32_SYSCALL_BIT + 102)
#define __NR_syslog (__X32_SYSCALL_BIT + 103)
#define __NR_getgid (__X32_SYSCALL_BIT + 104)
#define __NR_setuid (__X32_SYSCALL_BIT + 105)
#define __NR_setgid (__X32_SYSCALL_BIT + 106)
#define __NR_geteuid (__X32_SYSCALL_BIT + 107)
#define __NR_getegid (__X32_SYSCALL_BIT + 108)
#define __NR_setpgid (__X32_SYSCALL_BIT + 109)
#define __NR_getppid (__X32_SYSCALL_BIT + 110)
#define __NR_getpgrp (__X32_SYSCALL_BIT + 111)
#define __NR_setsid (__X32_SYSCALL_BIT + 112)
#define __NR_setreuid (__X32_SYSCALL_BIT + 113)
#define __NR_setregid (__X32_SYSCALL_BIT + 114)
#define __NR_getgroups (__X32_SYSCALL_BIT + 115)
#define __NR_setgroups (__X32_SYSCALL_BIT + 116)
#define __NR_setresuid (__X32_SYSCALL_BIT + 117)
#define __NR_getresuid (__X32_SYSCALL_BIT + 118)
#define __NR_setresgid (__X32_SYSCALL_BIT + 119)
#define __NR_getresgid (__X32_SYSCALL_BIT + 120)
#define __NR_getpgid (__X32_SYSCALL_BIT + 121)
#define __NR_setfsuid (__X32_SYSCALL_BIT + 122)
#define __NR_setfsgid (__X32_SYSCALL_BIT + 123)
#define __NR_getsid (__X32_SYSCALL_BIT + 124)
#define __NR_capget (__X32_SYSCALL_BIT + 125)
#define __NR_capset (__X32_SYSCALL_BIT + 126)
#define __NR_rt_sigsuspend (__X32_SYSCALL_BIT + 130)
#define __NR_utime (__X32_SYSCALL_BIT + 132)
#define __NR_mknod (__X32_SYSCALL_BIT + 133)
#define __NR_personality (__X32_SYSCALL_BIT + 135)
#define __NR_ustat (__X32_SYSCALL_BIT + 136)
#define __NR_statfs (__X32_SYSCALL_BIT + 137)
#define __NR_fstatfs (__X32_SYSCALL_BIT + 138)
#define __NR_sysfs (__X32_SYSCALL_BIT + 139)
#define __NR_getpriority (__X32_SYSCALL_BIT + 140)
#define __NR_setpriority (__X32_SYSCALL_BIT + 141)
#define __NR_sched_setparam (__X32_SYSCALL_BIT + 142)
#define __NR_sched_getparam (__X32_SYSCALL_BIT + 143)
#define __NR_sched_setscheduler (__X32_SYSCALL_BIT + 144)
#define __NR_sched_getscheduler (__X32_SYSCALL_BIT + 145)
#define __NR_sched_get_priority_max (__X32_SYSCALL_BIT + 146)
#define __NR_sched_get_priority_min (__X32_SYSCALL_BIT + 147)
#define __NR_sched_rr_get_interval (__X32_SYSCALL_BIT + 148)
#define __NR_mlock (__X32_SYSCALL_BIT + 149)
#define __NR_munlock (__X32_SYSCALL_BIT + 150)
#define __NR_mlockall (__X32_SYSCALL_BIT + 151)
#define __NR_munlockall (__X32_SYSCALL_BIT + 152)
#define __NR_vhangup (__X32_SYSCALL_BIT + 153)
#define __NR_modify_ldt (__X32_SYSCALL_BIT + 154)
#define __NR_pivot_root (__X32_SYSCALL_BIT + 155)
#define __NR_prctl (__X32_SYSCALL_BIT + 157)
#define __NR_arch_prctl (__X32_SYSCALL_BIT + 158)
#define __NR_adjtimex (__X32_SYSCALL_BIT + 159)
#define __NR_setrlimit (__X32_SYSCALL_BIT + 160)
#define __NR_chroot (__X32_SYSCALL_BIT + 161)
#define __NR_sync (__X32_SYSCALL_BIT + 162)
#define __NR_acct (__X32_SYSCALL_BIT + 163)
#define __NR_settimeofday (__X32_SYSCALL_BIT + 164)
#define __NR_mount (__X32_SYSCALL_BIT + 165)
#define __NR_umount2 (__X32_SYSCALL_BIT + 166)
#define __NR_swapon (__X32_SYSCALL_BIT + 167)
#define __NR_swapoff (__X32_SYSCALL_BIT + 168)
#define __NR_reboot (__X32_SYSCALL_BIT + 169)
#define __NR_sethostname (__X32_SYSCALL_BIT + 170)
#define __NR_setdomainname (__X32_SYSCALL_BIT + 171)
#define __NR_iopl (__X32_SYSCALL_BIT + 172)
#define __NR_ioperm (__X32_SYSCALL_BIT + 173)
#define __NR_init_module (__X32_SYSCALL_BIT + 175)
#define __NR_delete_module (__X32_SYSCALL_BIT + 176)
#define __NR_quotactl (__X32_SYSCALL_BIT + 179)
#define __NR_getpmsg (__X32_SYSCALL_BIT + 181)
#define __NR_putpmsg (__X32_SYSCALL_BIT + 182)
#define __NR_afs_syscall (__X32_SYSCALL_BIT + 183)
#define __NR_tuxcall (__X32_SYSCALL_BIT + 184)
#define __NR_security (__X32_SYSCALL_BIT + 185)
#define __NR_gettid (__X32_SYSCALL_BIT + 186)
#define __NR_readahead (__X32_SYSCALL_BIT + 187)
#define __NR_setxattr (__X32_SYSCALL_BIT + 188)
#define __NR_lsetxattr (__X32_SYSCALL_BIT + 189)
#define __NR_fsetxattr (__X32_SYSCALL_BIT + 190)
#define __NR_getxattr (__X32_SYSCALL_BIT + 191)
#define __NR_lgetxattr (__X32_SYSCALL_BIT + 192)
#define __NR_fgetxattr (__X32_SYSCALL_BIT + 193)
#define __NR_listxattr (__X32_SYSCALL_BIT + 194)
#define __NR_llistxattr (__X32_SYSCALL_BIT + 195)
#define __NR_flistxattr (__X32_SYSCALL_BIT + 196)
#define __NR_removexattr (__X32_SYSCALL_BIT + 197)
#define __NR_lremovexattr (__X32_SYSCALL_BIT + 198)
#define __NR_fremovexattr (__X32_SYSCALL_BIT + 199)
#define __NR_tkill (__X32_SYSCALL_BIT + 200)
#define __NR_time (__X32_SYSCALL_BIT + 201)
#define __NR_futex (__X32_SYSCALL_BIT + 202)
#define __NR_sched_setaffinity (__X32_SYSCALL_BIT + 203)
#define __NR_sched_getaffinity (__X32_SYSCALL_BIT + 204)
#define __NR_io_setup (__X32_SYSCALL_BIT + 206)
#define __NR_io_destroy (__X32_SYSCALL_BIT + 207)
#define __NR_io_getevents (__X32_SYSCALL_BIT + 208)
#define __NR_io_submit (__X32_SYSCALL_BIT + 209)
#define __NR_io_cancel (__X32_SYSCALL_BIT + 210)
#define __NR_lookup_dcookie (__X32_SYSCALL_BIT + 212)
#define __NR_epoll_create (__X32_SYSCALL_BIT + 213)
#define __NR_remap_file_pages (__X32_SYSCALL_BIT + 216)
#define __NR_getdents64 (__X32_SYSCALL_BIT + 217)
#define __NR_set_tid_address (__X32_SYSCALL_BIT + 218)
#define __NR_restart_syscall (__X32_SYSCALL_BIT + 219)
#define __NR_semtimedop (__X32_SYSCALL_BIT + 220)
#define __NR_fadvise64 (__X32_SYSCALL_BIT + 221)
#define __NR_timer_settime (__X32_SYSCALL_BIT + 223)
#define __NR_timer_gettime (__X32_SYSCALL_BIT + 224)
#define __NR_timer_getoverrun (__X32_SYSCALL_BIT + 225)
#define __NR_timer_delete (__X32_SYSCALL_BIT + 226)
#define __NR_clock_settime (__X32_SYSCALL_BIT + 227)
#define __NR_clock_gettime (__X32_SYSCALL_BIT + 228)
#define __NR_clock_getres (__X32_SYSCALL_BIT + 229)
#define __NR_clock_nanosleep (__X32_SYSCALL_BIT + 230)
#define __NR_exit_group (__X32_SYSCALL_BIT + 231)
#define __NR_epoll_wait (__X32_SYSCALL_BIT + 232)
#define __NR_epoll_ctl (__X32_SYSCALL_BIT + 233)
#define __NR_tgkill (__X32_SYSCALL_BIT + 234)
#define __NR_utimes (__X32_SYSCALL_BIT + 235)
#define __NR_mbind (__X32_SYSCALL_BIT + 237)
#define __NR_set_mempolicy (__X32_SYSCALL_BIT + 238)
#define __NR_get_mempolicy (__X32_SYSCALL_BIT + 239)
#define __NR_mq_open (__X32_SYSCALL_BIT + 240)
#define __NR_mq_unlink (__X32_SYSCALL_BIT + 241)
#define __NR_mq_timedsend (__X32_SYSCALL_BIT + 242)
#define __NR_mq_timedreceive (__X32_SYSCALL_BIT + 243)
#define __NR_mq_getsetattr (__X32_SYSCALL_BIT + 245)
#define __NR_add_key (__X32_SYSCALL_BIT + 248)
#define __NR_request_key (__X32_SYSCALL_BIT + 249)
#define __NR_keyctl (__X32_SYSCALL_BIT + 250)
#define __NR_ioprio_set (__X32_SYSCALL_BIT + 251)
#define __NR_ioprio_get (__X32_SYSCALL_BIT + 252)
#define __NR_inotify_init (__X32_SYSCALL_BIT + 253)
#define __NR_inotify_add_watch (__X32_SYSCALL_BIT + 254)
#define __NR_inotify_rm_watch (__X32_SYSCALL_BIT + 255)
#define __NR_migrate_pages (__X32_SYSCALL_BIT + 256)
#define __NR_openat (__X32_SYSCALL_BIT + 257)
#define __NR_mkdirat (__X32_SYSCALL_BIT + 258)
#define __NR_mknodat (__X32_SYSCALL_BIT + 259)
#define __NR_fchownat (__X32_SYSCALL_BIT + 260)
#define __NR_futimesat (__X32_SYSCALL_BIT + 261)
#define __NR_newfstatat (__X32_SYSCALL_BIT + 262)
#define __NR_unlinkat (__X32_SYSCALL_BIT + 263)
#define __NR_renameat (__X32_SYSCALL_BIT + 264)
#define __NR_linkat (__X32_SYSCALL_BIT + 265)
#define __NR_symlinkat (__X32_SYSCALL_BIT + 266)
#define __NR_readlinkat (__X32_SYSCALL_BIT + 267)
#define __NR_fchmodat (__X32_SYSCALL_BIT + 268)
#define __NR_faccessat (__X32_SYSCALL_BIT + 269)
#define __NR_pselect6 (__X32_SYSCALL_BIT + 270)
#define __NR_ppoll (__X32_SYSCALL_BIT + 271)
#define __NR_unshare (__X32_SYSCALL_BIT + 272)
#define __NR_splice (__X32_SYSCALL_BIT + 275)
#define __NR_tee (__X32_SYSCALL_BIT + 276)
#define __NR_sync_file_range (__X32_SYSCALL_BIT + 277)
#define __NR_utimensat (__X32_SYSCALL_BIT + 280)
#define __NR_epoll_pwait (__X32_SYSCALL_BIT + 281)
#define __NR_signalfd (__X32_SYSCALL_BIT + 282)
#define __NR_timerfd_create (__X32_SYSCALL_BIT + 283)
#define __NR_eventfd (__X32_SYSCALL_BIT + 284)
#define __NR_fallocate (__X32_SYSCALL_BIT + 285)
#define __NR_timerfd_settime (__X32_SYSCALL_BIT + 286)
#define __NR_timerfd_gettime (__X32_SYSCALL_BIT + 287)
#define __NR_accept4 (__X32_SYSCALL_BIT + 288)
#define __NR_signalfd4 (__X32_SYSCALL_BIT + 289)
#define __NR_eventfd2 (__X32_SYSCALL_BIT + 290)
#define __NR_epoll_create1 (__X32_SYSCALL_BIT + 291)
#define __NR_dup3 (__X32_SYSCALL_BIT + 292)
#define __NR_pipe2 (__X32_SYSCALL_BIT + 293)
#define __NR_inotify_init1 (__X32_SYSCALL_BIT + 294)
#define __NR_perf_event_open (__X32_SYSCALL_BIT + 298)
#define __NR_fanotify_init (__X32_SYSCALL_BIT + 300)
#define __NR_fanotify_mark (__X32_SYSCALL_BIT + 301)
#define __NR_prlimit64 (__X32_SYSCALL_BIT + 302)
#define __NR_name_to_handle_at (__X32_SYSCALL_BIT + 303)
#define __NR_open_by_handle_at (__X32_SYSCALL_BIT + 304)
#define __NR_clock_adjtime (__X32_SYSCALL_BIT + 305)
#define __NR_syncfs (__X32_SYSCALL_BIT + 306)
#define __NR_setns (__X32_SYSCALL_BIT + 308)
#define __NR_getcpu (__X32_SYSCALL_BIT + 309)
#define __NR_kcmp (__X32_SYSCALL_BIT + 312)
#define __NR_finit_module (__X32_SYSCALL_BIT + 313)
#define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
#define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
#define __NR_ioctl (__X32_SYSCALL_BIT + 514)
#define __NR_readv (__X32_SYSCALL_BIT + 515)
#define __NR_writev (__X32_SYSCALL_BIT + 516)
#define __NR_recvfrom (__X32_SYSCALL_BIT + 517)
#define __NR_sendmsg (__X32_SYSCALL_BIT + 518)
#define __NR_recvmsg (__X32_SYSCALL_BIT + 519)
#define __NR_execve (__X32_SYSCALL_BIT + 520)
#define __NR_ptrace (__X32_SYSCALL_BIT + 521)
#define __NR_rt_sigpending (__X32_SYSCALL_BIT + 522)
#define __NR_rt_sigtimedwait (__X32_SYSCALL_BIT + 523)
#define __NR_rt_sigqueueinfo (__X32_SYSCALL_BIT + 524)
#define __NR_sigaltstack (__X32_SYSCALL_BIT + 525)
#define __NR_timer_create (__X32_SYSCALL_BIT + 526)
#define __NR_mq_notify (__X32_SYSCALL_BIT + 527)
#define __NR_kexec_load (__X32_SYSCALL_BIT + 528)
#define __NR_waitid (__X32_SYSCALL_BIT + 529)
#define __NR_set_robust_list (__X32_SYSCALL_BIT + 530)
#define __NR_get_robust_list (__X32_SYSCALL_BIT + 531)
#define __NR_vmsplice (__X32_SYSCALL_BIT + 532)
#define __NR_move_pages (__X32_SYSCALL_BIT + 533)
#define __NR_preadv (__X32_SYSCALL_BIT + 534)
#define __NR_pwritev (__X32_SYSCALL_BIT + 535)
#define __NR_rt_tgsigqueueinfo (__X32_SYSCALL_BIT + 536)
#define __NR_recvmmsg (__X32_SYSCALL_BIT + 537)
#define __NR_sendmmsg (__X32_SYSCALL_BIT + 538)
#define __NR_process_vm_readv (__X32_SYSCALL_BIT + 539)
#define __NR_process_vm_writev (__X32_SYSCALL_BIT + 540)
#define __NR_setsockopt (__X32_SYSCALL_BIT + 541)
#define __NR_getsockopt (__X32_SYSCALL_BIT + 542)

#undef __NR_fstatat
#undef __NR_pread
#undef __NR_pwrite
#undef __NR_getdents
#define __NR_fstatat __NR_newfstatat
#define __NR_pread __NR_pread64
#define __NR_pwrite __NR_pwrite64
#define __NR_getdents __NR_getdents64
#define __NR_fadvise __NR_fadvise64



/* Repeat with SYS_ prefix */



#define SYS_read __NR_read
#define SYS_write __NR_write
#define SYS_open __NR_open
#define SYS_close __NR_close
#define SYS_stat __NR_stat
#define SYS_fstat __NR_fstat
#define SYS_lstat __NR_lstat
#define SYS_poll __NR_poll
#define SYS_lseek __NR_lseek
#define SYS_mmap __NR_mmap
#define SYS_mprotect __NR_mprotect
#define SYS_munmap __NR_munmap
#define SYS_brk __NR_brk
#define SYS_rt_sigprocmask __NR_rt_sigprocmask
#define SYS_pread64 __NR_pread64
#define SYS_pwrite64 __NR_pwrite64
#define SYS_access __NR_access
#define SYS_pipe __NR_pipe
#define SYS_select __NR_select
#define SYS_sched_yield __NR_sched_yield
#define SYS_mremap __NR_mremap
#define SYS_msync __NR_msync
#define SYS_mincore __NR_mincore
#define SYS_madvise __NR_madvise
#define SYS_shmget __NR_shmget
#define SYS_shmat __NR_shmat
#define SYS_shmctl __NR_shmctl
#define SYS_dup __NR_dup
#define SYS_dup2 __NR_dup2
#define SYS_pause __NR_pause
#define SYS_nanosleep __NR_nanosleep
#define SYS_getitimer __NR_getitimer
#define SYS_alarm __NR_alarm
#define SYS_setitimer __NR_setitimer
#define SYS_getpid __NR_getpid
#define SYS_sendfile __NR_sendfile
#define SYS_socket __NR_socket
#define SYS_connect __NR_connect
#define SYS_accept __NR_accept
#define SYS_sendto __NR_sendto
#define SYS_shutdown __NR_shutdown
#define SYS_bind __NR_bind
#define SYS_listen __NR_listen
#define SYS_getsockname __NR_getsockname
#define SYS_getpeername __NR_getpeername
#define SYS_socketpair __NR_socketpair
#define SYS_clone __NR_clone
#define SYS_fork __NR_fork
#define SYS_vfork __NR_vfork
#define SYS_exit __NR_exit
#define SYS_wait4 __NR_wait4
#define SYS_kill __NR_kill
#define SYS_uname __NR_uname
#define SYS_semget __NR_semget
#define SYS_semop __NR_semop
#define SYS_semctl __NR_semctl
#define SYS_shmdt __NR_shmdt
#define SYS_msgget __NR_msgget
#define SYS_msgsnd __NR_msgsnd
#define SYS_msgrcv __NR_msgrcv
#define SYS_msgctl __NR_msgctl
#define SYS_fcntl __NR_fcntl
#define SYS_flock __NR_flock
#define SYS_fsync __NR_fsync
#define SYS_fdatasync __NR_fdatasync
#define SYS_truncate __NR_truncate
#define SYS_ftruncate __NR_ftruncate
#define SYS_getdents __NR_getdents
#define SYS_getcwd __NR_getcwd
#define SYS_chdir __NR_chdir
#define SYS_fchdir __NR_fchdir
#define SYS_rename __NR_rename
#define SYS_mkdir __NR_mkdir
#define SYS_rmdir __NR_rmdir
#define SYS_creat __NR_creat
#define SYS_link __NR_link
#define SYS_unlink __NR_unlink
#define SYS_symlink __NR_symlink
#define SYS_readlink __NR_readlink
#define SYS_chmod __NR_chmod
#define SYS_fchmod __NR_fchmod
#define SYS_chown __NR_chown
#define SYS_fchown __NR_fchown
#define SYS_lchown __NR_lchown
#define SYS_umask __NR_umask
#define SYS_gettimeofday __NR_gettimeofday
#define SYS_getrlimit __NR_getrlimit
#define SYS_getrusage __NR_getrusage
#define SYS_sysinfo __NR_sysinfo
#define SYS_times __NR_times
#define SYS_getuid __NR_getuid
#define SYS_syslog __NR_syslog
#define SYS_getgid __NR_getgid
#define SYS_setuid __NR_setuid
#define SYS_setgid __NR_setgid
#define SYS_geteuid __NR_geteuid
#define SYS_getegid __NR_getegid
#define SYS_setpgid __NR_setpgid
#define SYS_getppid __NR_getppid
#define SYS_getpgrp __NR_getpgrp
#define SYS_setsid __NR_setsid
#define SYS_setreuid __NR_setreuid
#define SYS_setregid __NR_setregid
#define SYS_getgroups __NR_getgroups
#define SYS_setgroups __NR_setgroups
#define SYS_setresuid __NR_setresuid
#define SYS_getresuid __NR_getresuid
#define SYS_setresgid __NR_setresgid
#define SYS_getresgid __NR_getresgid
#define SYS_getpgid __NR_getpgid
#define SYS_setfsuid __NR_setfsuid
#define SYS_setfsgid __NR_setfsgid
#define SYS_getsid __NR_getsid
#define SYS_capget __NR_capget
#define SYS_capset __NR_capset
#define SYS_rt_sigsuspend __NR_rt_sigsuspend
#define SYS_utime __NR_utime
#define SYS_mknod __NR_mknod
#define SYS_personality __NR_personality
#define SYS_ustat __NR_ustat
#define SYS_statfs __NR_statfs
#define SYS_fstatfs __NR_fstatfs
#define SYS_sysfs __NR_sysfs
#define SYS_getpriority __NR_getpriority
#define SYS_setpriority __NR_setpriority
#define SYS_sched_setparam __NR_sched_setparam
#define SYS_sched_getparam __NR_sched_getparam
#define SYS_sched_setscheduler __NR_sched_setscheduler
#define SYS_sched_getscheduler __NR_sched_getscheduler
#define SYS_sched_get_priority_max __NR_sched_get_priority_max
#define SYS_sched_get_priority_min __NR_sched_get_priority_min
#define SYS_sched_rr_get_interval __NR_sched_rr_get_interval
#define SYS_mlock __NR_mlock
#define SYS_munlock __NR_munlock
#define SYS_mlockall __NR_mlockall
#define SYS_munlockall __NR_munlockall
#define SYS_vhangup __NR_vhangup
#define SYS_modify_ldt __NR_modify_ldt
#define SYS_pivot_root __NR_pivot_root
#define SYS_prctl __NR_prctl
#define SYS_arch_prctl __NR_arch_prctl
#define SYS_adjtimex __NR_adjtimex
#define SYS_setrlimit __NR_setrlimit
#define SYS_chroot __NR_chroot
#define SYS_sync __NR_sync
#define SYS_acct __NR_acct
#define SYS_settimeofday __NR_settimeofday
#define SYS_mount __NR_mount
#define SYS_umount2 __NR_umount2
#define SYS_swapon __NR_swapon
#define SYS_swapoff __NR_swapoff
#define SYS_reboot __NR_reboot
#define SYS_sethostname __NR_sethostname
#define SYS_setdomainname __NR_setdomainname
#define SYS_iopl __NR_iopl
#define SYS_ioperm __NR_ioperm
#define SYS_init_module __NR_init_module
#define SYS_delete_module __NR_delete_module
#define SYS_quotactl __NR_quotactl
#define SYS_getpmsg __NR_getpmsg
#define SYS_putpmsg __NR_putpmsg
#define SYS_afs_syscall __NR_afs_syscall
#define SYS_tuxcall __NR_tuxcall
#define SYS_security __NR_security
#define SYS_gettid __NR_gettid
#define SYS_readahead __NR_readahead
#define SYS_setxattr __NR_setxattr
#define SYS_lsetxattr __NR_lsetxattr
#define SYS_fsetxattr __NR_fsetxattr
#define SYS_getxattr __NR_getxattr
#define SYS_lgetxattr __NR_lgetxattr
#define SYS_fgetxattr __NR_fgetxattr
#define SYS_listxattr __NR_listxattr
#define SYS_llistxattr __NR_llistxattr
#define SYS_flistxattr __NR_flistxattr
#define SYS_removexattr __NR_removexattr
#define SYS_lremovexattr __NR_lremovexattr
#define SYS_fremovexattr __NR_fremovexattr
#define SYS_tkill __NR_tkill
#define SYS_time __NR_time
#define SYS_futex __NR_futex
#define SYS_sched_setaffinity __NR_sched_setaffinity
#define SYS_sched_getaffinity __NR_sched_getaffinity
#define SYS_io_setup __NR_io_setup
#define SYS_io_destroy __NR_io_destroy
#define SYS_io_getevents __NR_io_getevents
#define SYS_io_submit __NR_io_submit
#define SYS_io_cancel __NR_io_cancel
#define SYS_lookup_dcookie __NR_lookup_dcookie
#define SYS_epoll_create __NR_epoll_create
#define SYS_remap_file_pages __NR_remap_file_pages
#define SYS_getdents64 __NR_getdents64
#define SYS_set_tid_address __NR_set_tid_address
#define SYS_restart_syscall __NR_restart_syscall
#define SYS_semtimedop __NR_semtimedop
#define SYS_fadvise64 __NR_fadvise64
#define SYS_timer_settime __NR_timer_settime
#define SYS_timer_gettime __NR_timer_gettime
#define SYS_timer_getoverrun __NR_timer_getoverrun
#define SYS_timer_delete __NR_timer_delete
#define SYS_clock_settime __NR_clock_settime
#define SYS_clock_gettime __NR_clock_gettime
#define SYS_clock_getres __NR_clock_getres
#define SYS_clock_nanosleep __NR_clock_nanosleep
#define SYS_exit_group __NR_exit_group
#define SYS_epoll_wait __NR_epoll_wait
#define SYS_epoll_ctl __NR_epoll_ctl
#define SYS_tgkill __NR_tgkill
#define SYS_utimes __NR_utimes
#define SYS_mbind __NR_mbind
#define SYS_set_mempolicy __NR_set_mempolicy
#define SYS_get_mempolicy __NR_get_mempolicy
#define SYS_mq_open __NR_mq_open
#define SYS_mq_unlink __NR_mq_unlink
#define SYS_mq_timedsend __NR_mq_timedsend
#define SYS_mq_timedreceive __NR_mq_timedreceive
#define SYS_mq_getsetattr __NR_mq_getsetattr
#define SYS_add_key __NR_add_key
#define SYS_request_key __NR_request_key
#define SYS_keyctl __NR_keyctl
#define SYS_ioprio_set __NR_ioprio_set
#define SYS_ioprio_get __NR_ioprio_get
#define SYS_inotify_init __NR_inotify_init
#define SYS_inotify_add_watch __NR_inotify_add_watch
#define SYS_inotify_rm_watch __NR_inotify_rm_watch
#define SYS_migrate_pages __NR_migrate_pages
#define SYS_openat __NR_openat
#define SYS_mkdirat __NR_mkdirat
#define SYS_mknodat __NR_mknodat
#define SYS_fchownat __NR_fchownat
#define SYS_futimesat __NR_futimesat
#define SYS_newfstatat __NR_newfstatat
#define SYS_unlinkat __NR_unlinkat
#define SYS_renameat __NR_renameat
#define SYS_linkat __NR_linkat
#define SYS_symlinkat __NR_symlinkat
#define SYS_readlinkat __NR_readlinkat
#define SYS_fchmodat __NR_fchmodat
#define SYS_faccessat __NR_faccessat
#define SYS_pselect6 __NR_pselect6
#define SYS_ppoll __NR_ppoll
#define SYS_unshare __NR_unshare
#define SYS_splice __NR_splice
#define SYS_tee __NR_tee
#define SYS_sync_file_range __NR_sync_file_range
#define SYS_utimensat __NR_utimensat
#define SYS_epoll_pwait __NR_epoll_pwait
#define SYS_signalfd __NR_signalfd
#define SYS_timerfd_create __NR_timerfd_create
#define SYS_eventfd __NR_eventfd
#define SYS_fallocate __NR_fallocate
#define SYS_timerfd_settime __NR_timerfd_settime
#define SYS_timerfd_gettime __NR_timerfd_gettime
#define SYS_accept4 __NR_accept4
#define SYS_signalfd4 __NR_signalfd4
#define SYS_eventfd2 __NR_eventfd2
#define SYS_epoll_create1 __NR_epoll_create1
#define SYS_dup3 __NR_dup3
#define SYS_pipe2 __NR_pipe2
#define SYS_inotify_init1 __NR_inotify_init1
#define SYS_perf_event_open __NR_perf_event_open
#define SYS_fanotify_init __NR_fanotify_init
#define SYS_fanotify_mark __NR_fanotify_mark
#define SYS_prlimit64 __NR_prlimit64
#define SYS_name_to_handle_at __NR_name_to_handle_at
#define SYS_open_by_handle_at __NR_open_by_handle_at
#define SYS_clock_adjtime __NR_clock_adjtime
#define SYS_syncfs __NR_syncfs
#define SYS_setns __NR_setns
#define SYS_getcpu __NR_getcpu
#define SYS_kcmp __NR_kcmp
#define SYS_finit_module __NR_finit_module
#define SYS_rt_sigaction __NR_rt_sigaction
#define SYS_rt_sigreturn __NR_rt_sigreturn
#define SYS_ioctl __NR_ioctl
#define SYS_readv __NR_readv
#define SYS_writev __NR_writev
#define SYS_recvfrom __NR_recvfrom
#define SYS_sendmsg __NR_sendmsg
#define SYS_recvmsg __NR_recvmsg
#define SYS_execve __NR_execve
#define SYS_ptrace __NR_ptrace
#define SYS_rt_sigpending __NR_rt_sigpending
#define SYS_rt_sigtimedwait __NR_rt_sigtimedwait
#define SYS_rt_sigqueueinfo __NR_rt_sigqueueinfo
#define SYS_sigaltstack __NR_sigaltstack
#define SYS_timer_create __NR_timer_create
#define SYS_mq_notify __NR_mq_notify
#define SYS_kexec_load __NR_kexec_load
#define SYS_waitid __NR_waitid
#define SYS_set_robust_list __NR_set_robust_list
#define SYS_get_robust_list __NR_get_robust_list
#define SYS_vmsplice __NR_vmsplice
#define SYS_move_pages __NR_move_pages
#define SYS_preadv __NR_preadv
#define SYS_pwritev __NR_pwritev
#define SYS_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
#define SYS_recvmmsg __NR_recvmmsg
#define SYS_sendmmsg __NR_sendmmsg
#define SYS_process_vm_readv __NR_process_vm_readv
#define SYS_process_vm_writev __NR_process_vm_writev
#define SYS_setsockopt __NR_setsockopt
#define SYS_getsockopt __NR_getsockopt

#undef SYS_fstatat
#undef SYS_pread
#undef SYS_pwrite
#undef SYS_getdents
#define SYS_fstatat SYS_newfstatat
#define SYS_pread SYS_pread64
#define SYS_pwrite SYS_pwrite64
#define SYS_getdents SYS_getdents64
#define SYS_fadvise SYS_fadvise64
