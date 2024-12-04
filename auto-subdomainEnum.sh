#!/bin/bash

# Check if a domain argument is provided
if [ "$#" -ne 1 ]; then
    echo -e "\033[1;31mUsage: $0 <domain>\033[0m"
    exit 1
fi

DOMAIN=$1

# Welcome message
echo -e "\033[1;32m*******************************************************\033[0m"
echo -e "\033[1;34m  Subdomain Enumeration Tools by c0desec \033[0m"
echo -e "\033[1;36m        Automating Subdomain Discovery\033[0m"
echo -e "\033[1;32m*******************************************************\033[0m"
echo ""
echo -e "\033[1;33mTarget Domain:\033[0m $DOMAIN"
echo ""

# Step 1: Run subfinder and assetfinder
subfinder -d $DOMAIN > sub.txt
assetfinder --subs-only $DOMAIN > asf.txt

# Combine and sort subdomains into subdomains.txt
cat sub.txt asf.txt | sort -u > subdomains.txt
echo "Initial subdomains collected in subdomains.txt"

# Step 2: Filter invalid subdomains
INVALID=$(grep -E '^\*|^-|[^a-zA-Z0-9._-]|(^|\.)(https|http)--' subdomains.txt | grep -v "\.$DOMAIN$")
VALID=$(grep "\.$DOMAIN$" subdomains.txt | grep -v '^\*' | grep -v '^-')

# Display invalid subdomains for review
if [ -n "$INVALID" ]; then
    echo "The following invalid subdomains were found:"
    echo "$INVALID"
    read -p "Do you want to remove these invalid subdomains? (y/n): " CONFIRM
    if [[ "$CONFIRM" == "y" ]]; then
        echo "$VALID" > subdomains.txt
        echo "Invalid subdomains removed."
    else
        echo "No changes were made to subdomains.txt"
    fi
fi

# Step 3: Search for subdomains of subdomains iteratively
while :; do
    subfinder -dL subdomains.txt > sub-subs.txt
    
    PREVIOUS_COUNT=$(wc -l < subdomains.txt)
    NEW_COUNT=$(cat subdomains.txt sub-subs.txt | sort -u | wc -l)
    
    if [ "$NEW_COUNT" -gt "$PREVIOUS_COUNT" ]; then
        cat subdomains.txt sub-subs.txt | sort -u > sorted-sub-subs.txt
        mv sorted-sub-subs.txt subdomains.txt
        echo "New subdomains of subdomains found and added to subdomains.txt"
    else
        echo "No new subdomains found. Ending enumeration."
        break
    fi
done

# Step 4: Cleanup intermediate files
rm -f sub.txt asf.txt sub-subs.txt
echo "All intermediate files cleaned up. Final list saved in subdomains.txt"

echo "Subdomain enumeration completed for $DOMAIN"
