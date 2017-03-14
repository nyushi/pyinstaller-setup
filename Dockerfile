FROM centos:6.8

ENV PYTHON_VERSION 3.5.3

RUN yum groupinstall -y Development\ Tools && yum install -y zlib-devel openssl-devel sqlite3-devel wget tar
RUN \
       wget -q -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"\
    && mkdir -p /usr/src/python \
    && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
    && rm python.tar.xz \
    && cd /usr/src/python \
    && ./configure \
        --enable-loadable-sqlite-extensions \
        --enable-shared \
    && make -j$(nproc) \
    && make install \
    && echo '/usr/local/lib' >> /etc/ld.so.conf.d/local.conf \
    && ldconfig
