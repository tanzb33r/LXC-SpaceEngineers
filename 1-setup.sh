#!/bin/bash
dpkg --add-architecture i386 && \
mkdir -pm755 /etc/apt/keyrings && \
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources && \
apt update && \
apt install --install-recommends -y winehq-stable && \
apt install -y xvfb cabextract && \

mkdir -p /usr/share/steamcmd && cd /usr/share/steamcmd && \
curl -fsSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -zxvf - && \
chmod a+rx steamcmd.sh linux32/* && \
chmod -R a+rwx /usr/share/steamcmd && \
ln -sf /usr/share/steamcmd/steamcmd.sh /usr/local/bin/steamcmd && \

cd /usr/bin && \
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
chmod +x winetricks
