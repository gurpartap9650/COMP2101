#!/bin/bash

# Parse command line arguments
while getopts ":v:" opt; do
  case $opt in
    v)
      volume=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Use the volume argument to adjust the volume
if [[ -n "$volume" ]]; then
  echo "Setting volume to $volume"
  # Set volume using the command 'setvolume'
  setvolume $volume
fi

# Use an array to store data
data=("apple" "banana" "cherry" "date")

# Use a for loop to iterate over the array
for item in "${data[@]}"; do
  echo "$item"
done

# Use a while loop to read data from a file
while read line; do
  if [[ -n "$line" ]]; then
    echo "Line: $line"
  fi
done < input.txt 
# Use the case command to handle different input values
echo "Enter a number between 1 and 3"
read num
case $num in
  1)
    echo "You entered 1"
    ;;
  2)
    echo "You entered 2"
    ;;
  3)
    echo "You entered 3"
    ;;
  *)
    echo "Invalid input"
    ;;
esac
