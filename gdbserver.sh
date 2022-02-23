#! /bin/sh

LOGFILE="gdbserver.log"
GDBSERVER="/usr/local/bin/JLinkGDBServer"
DEVICE="ATSAMD21E18A"

${GDBSERVER} -select USB \
    -device ${DEVICE} \
    -endian little \
    -if SWD \
    -speed 4000 \
    -noir \
    -localhostonly \
    -timeout 2000 \
    -singlerun
#    -logtofile -log ${LOGFILE} \