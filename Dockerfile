FROM ubuntu:17.10

# INSTALL BASICS
RUN echo "v3.0.0"
RUN apt-get update
RUN apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim git wget wireless-tools bluetooth iw net-tools tshark golang

# CONFIGURE GO
ENV GOPATH="/root/go"
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"

# INSTALL find3-cli-scanner 
RUN go get -v github.com/schollz/find3-cli-scanner

# INSTALL BLUEZ FROM SOURCE
# This is commented out because its not needed except for information's sake
# and maybe if you want to use a smaller image (not Ubuntu:18)
# Instructions: https://github.com/schollz/gatt-python#installing-bluez-from-sources
#RUN  apt-get install -y libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev libdbus-glib-1-dev unzip systemd
#RUN mkdir /root/bluez
#WORKDIR /root/bluez
#RUN wget http://www.kernel.org/pub/linux/bluetooth/bluez-5.9.tar.xz
#RUN tar xf bluez-5.9.tar.xz
#WORKDIR /root/bluez/bluez-5.9
#RUN ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-library
#RUN make
#RUN make install
#RUN ln -svf /usr/libexec/bluetooth/bluetoothd /usr/sbin/
#RUN install -v -dm755 /etc/bluetooth
#RUN install -v -m644 src/main.conf /etc/bluetooth/main.conf
##RUN systemctl daemon-reload
##RUN systemctl start bluetooth
RUN bluetoothd --version

# BUILD THE SCANNER
WORKDIR /root/go/src/github.com/schollz/find3-cli-scanner
RUN go build -v
