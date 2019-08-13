FROM base/arch

RUN echo 'LANG="en_US.UTF-8"' > /etc/locale.conf
RUN pacman --quiet -Syy
RUN pacman --quiet -S --noconfirm base-devel scons libunistring

WORKDIR /home

RUN curl ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.1/gcc-4.9.1.tar.gz | tar xz
RUN curl ftp://gcc.gnu.org/pub/binutils/releases/binutils-2.24.tar.gz | tar xz
RUN curl http://flatassembler.net/fasm-1.71.17.tgz | tar xz
RUN mkdir cross
ENV PREFIX /home/cross
ENV TARGET x86_64-elf
ENV PATH /home/cross/bin:/home/fasm:$PATH

RUN mkdir build-binutils && cd build-binutils && \
    ../binutils-2.24/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-werror && \
    make && make install

RUN mkdir build-gcc && cd build-gcc && \
    ../gcc-4.9.1/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers && \
    make all-gcc && make all-target-libgcc && make install-gcc && make install-target-libgcc

