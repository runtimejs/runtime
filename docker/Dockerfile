FROM archlinux

RUN echo 'LANG="en_US.UTF-8"' > /etc/locale.conf

RUN pacman --quiet -Syy --noconfirm
RUN pacman --quiet -S --noconfirm base-devel
RUN pacman --quiet -S --noconfirm scons
RUN pacman --quiet -S --noconfirm libunistring
RUN cd home && curl ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.1/gcc-4.9.1.tar.gz | tar xz
RUN cd home && curl ftp://gcc.gnu.org/pub/binutils/releases/binutils-2.24.tar.gz | tar xz
RUN cd home && curl http://flatassembler.net/fasm-1.71.17.tgz | tar xz
RUN cd home && mkdir cross

ENV PREFIX /home/cross
ENV TARGET x86_64-elf
ENV PATH /home/cross/bin:/home/fasm:$PATH

RUN cd home && mkdir build-binutils && cd build-binutils && \
    ../binutils-2.24/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-werror && \
    make && make install

RUN cd home && mkdir build-gcc && cd build-gcc && \
    ../gcc-4.9.1/configure CXXFLAGS="-std=gnu++98" --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ && \
    make all-gcc && make all-target-libgcc && make install-gcc && make install-target-libgcc

RUN pacman -S --noconfirm nodejs npm
