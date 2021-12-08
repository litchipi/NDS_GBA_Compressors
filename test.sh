#!/bin/bash

set -e

function try_cmp() {
    echo "Trying $1 compression"
    cp icon.bmp $1.bmp
    ./$2 $1.bmp
    cp $1.bmp $1_restored.bmp
    ./$3 $1_restored.bmp
    shasum icon.bmp $1_restored.bmp
    ls -lh icon.bmp $1.bmp
    rm $1_restored.bmp
    echo ""
    echo "------------------------------------------------------------------------"
    echo "------------------------------------------------------------------------"
    echo "------------------------------------------------------------------------"
    echo -e "\n\n"
}

try_cmp "blz" "blz -eo" "blz -d"
try_cmp "huffman" "huffman -e0" "huffman -d"
try_cmp "lze" "lze -e" "lze -d"
try_cmp "lzss" "lzss -evo" "lzss -d"
try_cmp "lzx" "lzx -evl" "lzx -d"
try_cmp "rle" "rle -e" "rle -d"

ls -lh *.bmp |grep -v icon.bmp
