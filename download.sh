#!/bin/sh

JLINK="/usr/local/bin/JLinkExe"
DEVICE="ATSAMD21E18A"
COMMANDFILE="commandfile.jlink"

${JLINK} -nogui 1 -device ${DEVICE} -if SWD -speed 4000 -autoconnect 1 -commandfile ${COMMANDFILE}