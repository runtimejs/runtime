#define _IOC(a,b,c,d) ( ((a)<<30) | ((b)<<8) | (c) | ((d)<<16) )
#define _IOC_NONE  0U
#define _IOC_WRITE 1U
#define _IOC_READ  2U

#define _IO(a,b) _IOC(_IOC_NONE,(a),(b),0)
#define _IOW(a,b,c) _IOC(_IOC_WRITE,(a),(b),sizeof(c))
#define _IOR(a,b,c) _IOC(_IOC_READ,(a),(b),sizeof(c))
#define _IOWR(a,b,c) _IOC(_IOC_READ|_IOC_WRITE,(a),(b),sizeof(c))

#define FIOCLEX             _IO('f',  1)
#define FIONCLEX            _IO('f',  2)
#define FIOASYNC            _IOW('f', 125, int)
#define FIONBIO             _IOW('f', 126, int)
#define FIONREAD            _IOR('f', 127, int)
#define TIOCINQ             FIONREAD
#define FIOQSIZE            _IOR('f', 128, char[8])

#define TCGETA              _IOR('t', 23, char[18])
#define TCSETA              _IOW('t', 24, char[18])
#define TCSETAW             _IOW('t', 25, char[18])
#define TCSETAF             _IOW('t', 28, char[18])

#define TCSBRK              _IO('t', 29)
#define TCXONC              _IO('t', 30)
#define TCFLSH              _IO('t', 31)

#define TIOCSWINSZ          _IOW('t', 103, char[8])
#define TIOCGWINSZ          _IOR('t', 104, char[8])
#define TIOCSTART           _IO('t',  110)
#define TIOCSTOP            _IO('t',  111)
#define TIOCOUTQ            _IOR('t', 115, int)

#define TIOCSPGRP           _IOW('t', 118, int)
#define TIOCGPGRP           _IOR('t', 119, int)

#define TIOCEXCL            _IO('T', 12)
#define TIOCNXCL            _IO('T', 13)
#define TIOCSCTTY           _IO('T', 14)

#define TIOCSTI             _IOW('T', 18, char)
#define TIOCMGET            _IOR('T', 21, unsigned int)
#define TIOCMBIS            _IOW('T', 22, unsigned int)
#define TIOCMBIC            _IOW('T', 23, unsigned int)
#define TIOCMSET            _IOW('T', 24, unsigned int)
#define TIOCM_LE            0x001
#define TIOCM_DTR           0x002
#define TIOCM_RTS           0x004
#define TIOCM_ST            0x008
#define TIOCM_SR            0x010
#define TIOCM_CTS           0x020
#define TIOCM_CAR           0x040
#define TIOCM_RNG           0x080
#define TIOCM_DSR           0x100
#define TIOCM_CD            TIOCM_CAR
#define TIOCM_RI            TIOCM_RNG
#define TIOCM_OUT1          0x2000
#define TIOCM_OUT2          0x4000
#define TIOCM_LOOP          0x8000

#define TIOCGSOFTCAR        _IOR('T', 25, unsigned int)
#define TIOCSSOFTCAR        _IOW('T', 26, unsigned int)
#define TIOCLINUX           _IOW('T', 28, char)
#define TIOCCONS            _IO('T',  29)
#define TIOCGSERIAL         _IOR('T', 30, char[60])
#define TIOCSSERIAL         _IOW('T', 31, char[60])
#define TIOCPKT             _IOW('T', 32, int)
#define TIOCPKT_DATA        0
#define TIOCPKT_FLUSHREAD   1
#define TIOCPKT_FLUSHWRITE  2
#define TIOCPKT_STOP        4
#define TIOCPKT_START       8
#define TIOCPKT_NOSTOP      16
#define TIOCPKT_DOSTOP      32
#define TIOCPKT_IOCTL       64

#define TIOCNOTTY           _IO('T',  34)
#define TIOCSETD            _IOW('T', 35, int)
#define TIOCGETD            _IOR('T', 36, int)
#define TCSBRKP             _IOW('T', 37, int)
#define TIOCSBRK            _IO('T',  39)
#define TIOCCBRK            _IO('T',  40)
#define TIOCGSID            _IOR('T', 41, int)
#define TCGETS              _IOR('T', 42, char[44])
#define TCSETS              _IOW('T', 43, char[44])
#define TCSETSW             _IOW('T', 44, char[44])
#define TCSETSF             _IOW('T', 45, char[44])
#define TIOCGPTN            _IOR('T', 48, unsigned int)
#define TIOCSPTLCK          _IOW('T', 49, int)
#define TIOCGDEV            _IOR('T', 50, unsigned int)
#define TIOCSIG             _IOW('T', 54, int)
#define TIOCVHANGUP         _IO('T',  55)
#define TIOCGPKT            _IOR('T', 56, int)
#define TIOCGPTLCK          _IOR('T', 57, int)
#define TIOCGEXCL           _IOR('T', 64, int)

#define TIOCSERCONFIG       _IO('T',  83)
#define TIOCSERGWILD        _IOR('T', 84, int)
#define TIOCSERSWILD        _IOW('T', 85, int)
#define TIOCGLCKTRMIOS      _IO('T',  86)
#define TIOCSLCKTRMIOS      _IO('T',  87)
#define TIOCSERGSTRUCT      _IOR('T', 88, char[216])
#define TIOCSERGETLSR       _IOR('T', 89, unsigned int)
#define TIOCSER_TEMT        0x01
#define TIOCSERGETMULTI     _IOR('T', 90, char[168])
#define TIOCSERSETMULTI     _IOW('T', 91, char[168])

#define TIOCMIWAIT          _IO('T', 92)
#define TIOCGICOUNT         _IO('T', 93)

struct winsize {
    unsigned short ws_row;
    unsigned short ws_col;
    unsigned short ws_xpixel;
    unsigned short ws_ypixel;
};

#define TIOCM_MODEM_BITS TIOCM_OUT2

#define N_TTY           0
#define N_SLIP          1
#define N_MOUSE         2
#define N_PPP           3
#define N_STRIP         4
#define N_AX25          5
#define N_X25           6
#define N_6PACK         7
#define N_MASC          8
#define N_R3964         9
#define N_PROFIBUS_FDL  10
#define N_IRDA          11
#define N_SMSBLOCK      12
#define N_HDLC          13
#define N_SYNC_PPP      14
#define N_HCI           15

#define FIOGETOWN       _IOR('f', 123, int)
#define FIOSETOWN       _IOW('f', 124, int)

#define SIOCATMARK      _IOR('s', 7, int)
#define SIOCSPGRP       _IOW('s', 8, int)
#define SIOCGPGRP       _IOW('s', 9, int)
#define SIOCGSTAMP      _IOR('s', 100, char[8])

#define SIOCADDRT       0x890B
#define SIOCDELRT       0x890C
#define SIOCRTMSG       0x890D

#define SIOCGIFNAME     0x8910
#define SIOCSIFLINK     0x8911
#define SIOCGIFCONF     0x8912
#define SIOCGIFFLAGS    0x8913
#define SIOCSIFFLAGS    0x8914
#define SIOCGIFADDR     0x8915
#define SIOCSIFADDR     0x8916
#define SIOCGIFDSTADDR  0x8917
#define SIOCSIFDSTADDR  0x8918
#define SIOCGIFBRDADDR  0x8919
#define SIOCSIFBRDADDR  0x891a
#define SIOCGIFNETMASK  0x891b
#define SIOCSIFNETMASK  0x891c
#define SIOCGIFMETRIC   0x891d
#define SIOCSIFMETRIC   0x891e
#define SIOCGIFMEM      0x891f
#define SIOCSIFMEM      0x8920
#define SIOCGIFMTU      0x8921
#define SIOCSIFMTU      0x8922
#define SIOCSIFHWADDR   0x8924
#define SIOCGIFENCAP    0x8925
#define SIOCSIFENCAP    0x8926
#define SIOCGIFHWADDR   0x8927
#define SIOCGIFSLAVE    0x8929
#define SIOCSIFSLAVE    0x8930
#define SIOCADDMULTI    0x8931
#define SIOCDELMULTI    0x8932
#define SIOCGIFINDEX    0x8933
#define SIOGIFINDEX     SIOCGIFINDEX
#define SIOCSIFPFLAGS   0x8934
#define SIOCGIFPFLAGS   0x8935
#define SIOCDIFADDR     0x8936
#define SIOCSIFHWBROADCAST 0x8937
#define SIOCGIFCOUNT    0x8938

#define SIOCGIFBR       0x8940
#define SIOCSIFBR       0x8941

#define SIOCGIFTXQLEN   0x8942
#define SIOCSIFTXQLEN   0x8943

#define SIOCDARP        0x8953
#define SIOCGARP        0x8954
#define SIOCSARP        0x8955

#define SIOCDRARP       0x8960
#define SIOCGRARP       0x8961
#define SIOCSRARP       0x8962

#define SIOCGIFMAP      0x8970
#define SIOCSIFMAP      0x8971

#define SIOCADDDLCI     0x8980
#define SIOCDELDLCI     0x8981

#define SIOCDEVPRIVATE      0x89F0
#define SIOCPROTOPRIVATE    0x89E0
