sudo dpkg --add-architecture i386 
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
sudo apt update
sudo apt install --install-recommends winehq-stable
sudo apt install xvfb
sudo apt install cabextract

mkdir -p /usr/share/steamcmd && cd /usr/share/steamcmd
curl -fsSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -zxvf -
chmod a+rx steamcmd.sh linux32/*
chmod -R a+rwx /usr/share/steamcmd
ln -sf /usr/share/steamcmd/steamcmd.sh /usr/local/bin/steamcmd

cd /usr/bin
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks

cd /spaceengineers
mkdir /wineprefix

follow: https://github.com/mmmaxwwwell/space-engineers-dedicated-docker-linux/tree/main

cd /appdata/space-engineers/SpaceEngineersDedicated/DedicatedServer64/
env WINEARCH=win64 WINEDEBUG=-all WINEPREFIX=/wineprefix wine /appdata/space-engineers/SpaceEngineersDedicated/DedicatedServer64/SpaceEngineersDedicated.exe -noconsole -path Z:\\appdata\\space-engineers\\SpaceEngineersDedicated -ignorelastsession
