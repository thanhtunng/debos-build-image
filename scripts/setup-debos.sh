#!/bin/bash

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        gcc \
        git \
        golang-go \
        libc6-dev \
        libostree-dev \
        apt-transport-https \
        binfmt-support \
        bmap-tools \
        btrfs-progs \
        busybox \
        bzip2 \
        ca-certificates \
        debootstrap \
        dosfstools \
        e2fsprogs \
        equivs \
        fdisk \
        f2fs-tools \
        git \
        gzip \
        pigz \
        libostree-1-1 \
        linux-image-amd64 \
        parted \
        pkg-config \
        qemu-system-x86 \
        qemu-user-static \
        systemd \
        systemd-container \
        u-boot-tools \
        unzip \
        user-mode-linux \
        xz-utils \
        zip \
        curl \
        openssh-client \
        lavacli \
        libslirp-helper
sudo rm -rf /var/lib/apt/lists/*

git config --global http.proxy "$http_proxy"
git config --global https.proxy "$http_proxy"

[ ! -f "/usr/share/ca-certificates/toshiba.cer" ] && wget -e http_proxy=$http_proxy -e https_proxy=$http_proxy --no-proxy http://www.iss.toshiba.co.jp/services/ss/ca/manual/certificate/toshiba.cer && mv toshiba.cer /usr/share/ca-certificates/
[ ! -f "/usr/share/ca-certificates/toshibaca.cer" ] && wget -e http_proxy=$http_proxy -e https_proxy=$http_proxy --no-proxy http://www.iss.toshiba.co.jp/services/ss/ca/manual/certificate/toshibaca.cer && mv toshibaca.cer /usr/share/ca-certificates/

if [[ -z $(grep "toshiba.cer" /etc/ca-certificates.conf) ]]; then
	sudo echo toshiba.cer >> /etc/ca-certificates.conf
fi
if [[ -z $(grep "toshibaca.cer" /etc/ca-certificates.conf) ]]; then
	sudo echo toshibaca.cer >> /etc/ca-certificates.conf
fi
sudo update-ca-certificates

# Download debos
if [ ! -d "$GOPATH/src/github.com/go-debos/debos" ]; then
	 mkdir -p "$GOPATH/src/github.com/go-debos/debos" 
fi
cd "$GOPATH/src/github.com/go-debos/debos"
[ -z "$(ls -A .)" ] && git clone https://tosspedia.swc.toshiba.co.jp/gitlab/skelios/debos/skelios-debos.git .

# Build debos
if [[ -z $(command -v debos) ]]; then
	echo "Building debos ..."
	go get -t ./...
	go build	
	sudo cp $GOPATH/bin/debos /usr/local/bin/
	echo "DONE."
fi
