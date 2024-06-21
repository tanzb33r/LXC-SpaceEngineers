#!/bin/bash
mkdir -p /appdata/space-engineers/bin && \
mkdir -p /appdata/space-engineers/SpaceEngineersDedicated && \
mkdir -p /appdata/space-engineers/Plugins && \
mkdir -p /appdata/space-engineers/config && \
mkdir -p /appdata/space-engineers/config/World && \

if [ ! -f /appdata/space-engineers/config/World/Sandbox.sbc ]; then
    echo "World not found, initalizing empty star system..."
    unzip -n star-system.zip -d /appdata/space-engineers/config
fi

# #check if /appdata/space-engineers/config/World is a folder
if [ ! -d "/appdata/space-engineers/config/World" ]; then
  echo "World folder does not exist, exiting"
  exit 129
fi

# #check if /appdata/space-engineers/config/World/Sandbox.sbc exists and is a file
if [ ! -f "/appdata/space-engineers/config/World/Sandbox.sbc" ]; then
  echo "Sandbox.sbc file does not exist, exiting."
  exit 130
fi

# #check if /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg is a file
if [ ! -f "/appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg" ]; then
  echo "SpaceEngineers-Dedicated.cfg file does not exist, exiting."
  exit 131
fi

#set <LoadWorld> to the correct value
cat /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg | sed -E '/.*LoadWorld.*/c\  <LoadWorld>Z:\\appdata\\space-engineers\\World</LoadWorld>' > /tmp/SpaceEngineers-Dedicated.cfg && cat /tmp/SpaceEngineers-Dedicated.cfg > /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg && \

#set game port to the correct value
#cat /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg | sed -E '/.*ServerPort.*/c\  <ServerPort>27016</ServerPort>' > /tmp/SpaceEngineers-Dedicated.cfg && cat /tmp/SpaceEngineers-Dedicated.cfg > /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg && \

#configure plugins section in SpaceEngineers-Dedicated.cfg
#get new plugins string

if [ "$(ls -1 /appdata/space-engineers/Plugins/*.dll | wc -l)" -gt "0" ]; then
  PLUGINS_STRING=$(ls -1 /appdata/space-engineers/Plugins/*.dll |\ 
  awk '{ print "<string>" $0 "</string>" }' |\
  tr -d '\n' |\
  awk '{ print "<Plugins>" $0 "</Plugins>" }' ) && \
else
  PLUGINS_STRING="<Plugins />"
fi

SED_EXPRESSION_EMPTY="s/<Plugins \/>/${PLUGINS_STRING////\\/} /g"
SED_EXPRESSION_FULL="s/<Plugins>.*<\/Plugins>/${PLUGINS_STRING////\\/} /g"

#find and replace in SpaceEngineers-Dedicated.cfg for empty "<Plugins />" element
cat /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg | sed -E "$SED_EXPRESSION_EMPTY" > /tmp/SpaceEngineers-Dedicated.cfg && cat /tmp/SpaceEngineers-Dedicated.cfg > /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg && \

#find and replace in SpaceEngineers-Dedicated.cfg for filled out "<Plugins>...</Plugins>" element
# sed can't handle multiple lines easily, so everything needs to be on a single line.
cat /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg | sed -E "$SED_EXPRESSION_FULL" > /tmp/SpaceEngineers-Dedicated.cfg && cat /tmp/SpaceEngineers-Dedicated.cfg > /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg && \

cp /appdata/space-engineers/config/SpaceEngineers-Dedicated.cfg /appdata/space-engineers/SpaceEngineersDedicated/SpaceEngineers-Dedicated.cfg && \

steamcmd +login anonymous +@sSteamCmdForcePlatformType windows +force_install_dir /appdata/space-engineers/SpaceEngineersDedicated +app_update 298740 +quit
