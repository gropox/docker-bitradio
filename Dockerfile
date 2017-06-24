
FROM ubuntu:zesty

RUN apt-get update && \
	apt-get install -y libboost-dev libssl-dev libminiupnpc-dev libsecp256k1-dev libdb5.3++-dev && \
	apt-get install -y automake autoconf libtool git ecdsautils libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler && \
	apt-get install -y autotools-dev build-essential g++ libbz2-dev libicu-dev python-dev wget doxygen python3 python3-dev libboost-all-dev curl && \
        apt-get clean -qy

# P2P (seed) port
#EXPOSE 2229
# RPC ports
#EXPOSE 5000
#EXPOSE 8090


RUN cd ~ && \
	git clone https://github.com/thebitradio/Bitradio && \
	cd Bitradio/src && \
    cd secp256k1 && ./autogen.sh && ./configure --enable-module-recovery && make && cd .. && \
    make -f makefile.unix && \
    cd .. && \
    cp src/Bitradiod /usr/local/bin/ && \
    echo '/usr/local/bin/Bitradiod -datadir=/bitradio/ $@' >/usr/local/bin/brad && \
    chmod a+x /usr/local/bin/brad
    
VOLUME /bitradio
WORKDIR /bitradio

RUN echo "Please configure me! You need to mount a data directory onto /bitradio of this container to it to function correctly. "
CMD ["/usr/local/bin/Bitradiod", "-datadir=/bitradio" ]
