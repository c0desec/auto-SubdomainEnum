# auto-SubdomainEnum
Subdomain Enumeration Tools by c0desec

A Bash script for automating subdomain enumeration using readily available tools on Kali Linux such as subfinder and assetfinder. This tool ensures comprehensive subdomain discovery, filters out invalid entries, and recursively searches for subdomains of subdomains.

Features
Automated Subdomain Discovery: Uses subfinder and assetfinder to gather subdomains.
Validation: Filters invalid subdomains (e.g., those starting with * or -, or unrelated to the target domain).
Recursive Enumeration: Finds subdomains of subdomains until no new subdomains are discovered.
User Interaction: Displays invalid subdomains and prompts for user confirmation before removing them.
Cleanup: Removes intermediate files and saves the final result in a single file.
Prerequisites
Ensure you have the following tools installed (available by default on Kali Linux):

subfinder
assetfinder
You can install them using:
sudo apt update
sudo apt install subfinder assetfinder

Usage
./autoSubdomainEnum coinbase.com
