#!/bin/bash

# ASCII Art Banner
echo -e "\033[1m" # Start bold
echo " _____           _ _____              "
echo "|     |___ ___ _| |   __|___ ___ ___ "
echo "|   --|  _| -_| . |  |  |  _| -_| . |"
echo "|_____|_| |___|___|_____|_| |___|  _|"
echo "          {Grep for Creds}      |_|   "
echo -e "\033[0m" # Reset to normal

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Assign the first argument to a variable
input_file="$1"

# List of keywords to search for
keywords=(
  "password"
  "pass"
  "pwd"
  "cred"
)

# Create a summary associative array
declare -A summary

# Loop through each keyword in the array
for keyword in "${keywords[@]}"; do
  echo -e "\n\033[1;34mSearching for: \033[1;32m$keyword\033[0m" # Blue header with green keyword
  matches=$(grep -i -n --color=always "$keyword" "$input_file")

  # Check if matches were found
  if [ -n "$matches" ]; then
    echo -e "$matches"
    summary[$keyword]=$(echo "$matches" | wc -l) # Count matches
  else
    echo -e "\033[1;31m[-] No matches found.\033[0m" # Red for no matches
    summary[$keyword]=0                              # No matches
  fi
done

# Summary of results
echo -e "\n\033[1;34mSummary of Results:\033[0m"
for keyword in "${!summary[@]}"; do
  echo -e "$keyword: \033[1;32m${summary[$keyword]}\033[0m matches" # Green for counts
done
