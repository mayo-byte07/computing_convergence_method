#!/bin/bash

#! CONFIG VARS
DEST_DIR="/home/matthew/remote_computing_convergence_method"
PI_USER="matthew"
PI_HOST="192.168.1.124"
SSH_KEY="~/.ssh/id_rsa"
LOCAL_ASM_DIR="./asm"
LOCAL_STATS_DIR="./stats"
SRC_DIR="./src"
#! CONFIG VARS

clear

if [ -z "$1" ]; then
    echo "error: usage: ./run.sh <file.c> <flags>"
    exit 1
fi

FILE_PATH="$1"
shift
GCC_FLAGS="$@"

FILE_NAME=$(basename "$FILE_PATH")
FILE_DIR=$(dirname "$FILE_PATH")

PI_PATH="$DEST_DIR/src/$FILE_NAME"
OUT_FILE="${PI_PATH%.c}.out"
ASM_FILE="${PI_PATH%.c}.s"
REPORT_FILE="${PI_PATH%.c}_perf_report.txt"

mkdir -p "$LOCAL_ASM_DIR" "$LOCAL_STATS_DIR"

ssh -i $SSH_KEY $PI_USER@$PI_HOST "mkdir -p $DEST_DIR/src"
scp -i $SSH_KEY "$FILE_PATH" $PI_USER@$PI_HOST:$DEST_DIR/src/

# ssh -i $SSH_KEY $PI_USER@$PI_HOST "gcc -S -mcpu=cortex-a72 -O3 -fno-stack-protector -fomit-frame-pointer $GCC_FLAGS -o $ASM_FILE $PI_PATH -lm"
ssh -i $SSH_KEY $PI_USER@$PI_HOST "gcc -mcpu=cortex-a72 -O3 -fno-stack-protector -fomit-frame-pointer -march=armv8-a -fprefetch-loop-arrays -mtune=cortex-a72 -ftree-vectorize -funroll-loops $GCC_FLAGS -o $OUT_FILE $PI_PATH -lm"
# ssh -i $SSH_KEY $PI_USER@$PI_HOST "gcc $GCC_FLAGS -o $OUT_FILE $PI_PATH -lm"

COMPILATION_STATUS=$?
if [ $COMPILATION_STATUS -ne 0 ]; then
    echo "error generating asm"
    exit 1
fi

scp -i $SSH_KEY $PI_USER@$PI_HOST:$ASM_FILE "$LOCAL_ASM_DIR/"
cat "$LOCAL_ASM_DIR/$(basename $ASM_FILE)"

# ssh -i $SSH_KEY $PI_USER@$PI_HOST "gcc -mcpu=cortex-a72 -O3 -fno-stack-protector -fomit-frame-pointer $GCC_FLAGS -o $OUT_FILE $PI_PATH -lm"
ssh -i $SSH_KEY $PI_USER@$PI_HOST "gcc -S -mcpu=cortex-a72 -O3 -fno-stack-protector -fomit-frame-pointer -march=armv8-a -fprefetch-loop-arrays -mtune=cortex-a72 -ftree-vectorize -funroll-loops $GCC_FLAGS -o $ASM_FILE $PI_PATH -lm"
# ssh -i $SSH_KEY $PI_USER@$PI_HOST "gcc -S $GCC_FLAGS -o $ASM_FILE $PI_PATH -lm"

COMPILATION_STATUS=$?
if [ $COMPILATION_STATUS -ne 0 ]; then
    exit 1
fi

ssh -i $SSH_KEY $PI_USER@$PI_HOST "
if [ -f $OUT_FILE ]; then
    perf stat -o $REPORT_FILE $OUT_FILE;
else
    echo 'error, binary not found @ $OUT_FILE';
    exit 1;
fi"

scp -i $SSH_KEY $PI_USER@$PI_HOST:$REPORT_FILE "$LOCAL_STATS_DIR/"
cat "$LOCAL_STATS_DIR/$(basename $REPORT_FILE)"

clear
ssh -t -i $SSH_KEY $PI_USER@$PI_HOST "
if [ -f $OUT_FILE ]; then
    $OUT_FILE;
else
    echo 'binary not found for execution';
fi"
