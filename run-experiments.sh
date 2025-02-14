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

# Combine english.test and the provided FILENAME into a new file
cat english.test $FILENAME > "combined_inputs/english-${BASENAME}.txt"
echo "Combined input file created: combined_inputs/english-${BASENAME}.txt"

# Run the java command 9 times
for i in {1..9}
do
    echo "Running iteration $i..."
    java -jar negsel2.jar -self english.train -n 10 -r $i -c -l < "combined_inputs/english-${BASENAME}.txt" > "tests/test-english-${BASENAME}-${i}.txt"
    echo "Output saved to tests/test-english-${BASENAME}-${i}.txt"
done

echo "All iterations completed."