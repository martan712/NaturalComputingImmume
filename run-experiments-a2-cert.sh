#!/bin/bash

# Check if the script received a filename argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <FILENAME>"
    exit 1
fi

# Get the filename from the argument
FILENAME=$1

# Strip the extension from the filename (e.g., "hiligaynon.txt" becomes "hiligaynon")
BASENAME=$(basename "${FILENAME%.*}")

# Run the java command 9 times
for i in {1..9}
do
    echo "Running iteration $i..."
    java -jar negsel2.jar -self syscalls/snd-cert/formatted/snd-cert-n10-oTrue-s5.train -alphabet file://syscalls/snd-cert/snd-cert.alpha -n 10 -r $i -c -l < "syscalls/snd-cert/formatted/${FILENAME}.test" > "syscalls/snd-cert/tests/test-syscall-${FILENAME}-${i}.txt"
    echo "Output saved to tests/test-english-${BASENAME}-${i}.txt"
done

echo "All iterations completed."