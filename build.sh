#!/bin/bash

if [ -z "$1" ]; then
  echo "No arguments supplied"
  exit 1
fi

input="$1"
REMOVE_TEMP=false
OUTPUT_DIR="output"
TARGET="azullvm"

shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    -t|--target)
    echo "Setting target to $2"
      TARGET=$2
      shift
      shift
      ;;
    -RT|--remove-temp)
      REMOVE_TEMP=true
      shift
      ;;    
    *)
        echo "Unknown argument: $1"
        exit 1
        ;;
  esac
  shift
done

set -e

filename="$(basename $input)"
filename="${filename%%.*}"
mkdir -p $OUTPUT_DIR


echo "Building ${filename}.$TARGET"
echo Azurite $input -t "${TARGET}" -o "$OUTPUT_DIR/${filename}"
Azurite $input -t "${TARGET}" -o "$OUTPUT_DIR/${filename}"



case "$TARGET" in
  azullvm)
    echo "Compiling ${filename}.$TARGET to LLVM IR"
    echo azullvm "$OUTPUT_DIR/${filename}.$TARGET" "$OUTPUT_DIR/${filename}.ll"
    azullvm "$OUTPUT_DIR/${filename}.$TARGET" 2> "$OUTPUT_DIR/${filename}.ll"
    llc-10 "$OUTPUT_DIR/${filename}.ll" -o "$OUTPUT_DIR/${filename}.s"
    gcc "$OUTPUT_DIR/${filename}.s" -o "$OUTPUT_DIR/${filename}"
    ;;
   azurir)
    AZIR "$OUTPUT_DIR/${filename}.$TARGET" -o "$OUTPUT_DIR/${filename}.azvm"
    azvm "$OUTPUT_DIR/${filename}.azvm"
esac