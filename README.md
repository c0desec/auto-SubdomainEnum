# auto-SubdomainEnum

A Bash workflow for collecting, validating, deduplicating, and recursively expanding subdomain candidates with `subfinder` and `assetfinder`.

## Features

- Combines results from `subfinder` and `assetfinder`
- Removes duplicate entries
- Filters malformed or unrelated candidates
- Shows invalid entries before removal
- Repeats enumeration against newly discovered subdomains until no new results are found
- Cleans up intermediate files and consolidates the final results

## Requirements

- Linux with Bash
- [`subfinder`](https://github.com/projectdiscovery/subfinder)
- [`assetfinder`](https://github.com/tomnomnom/assetfinder)

Confirm both tools are available before running the script:

```bash
subfinder -version
assetfinder --help
```

## Installation

```bash
git clone https://github.com/c0desec/auto-SubdomainEnum.git
cd auto-SubdomainEnum
chmod +x auto-subdomainEnum.sh
```

## Usage

Run the script with a root domain:

```bash
./auto-subdomainEnum.sh example.com
```

Review any invalid candidates when prompted. The script removes temporary files and keeps the consolidated result in the working directory.

## Workflow

1. Gather candidates from both enumeration tools.
2. Normalize and deduplicate results.
3. Filter entries that are malformed or outside the requested domain.
4. Enumerate newly discovered subdomains recursively.
5. Stop when an iteration produces no new results.

## Notes and limitations

- Coverage depends on the data sources and configuration used by the underlying tools.
- Recursive enumeration can substantially increase runtime on large domains.
- Passive sources can return stale or unresolvable names; validate important results separately.
- Tool output formats may change and can require parser updates.

## Responsible use

Use this tool only for assets you own or are explicitly authorized to assess. Respect provider rate limits and the rules of the program or engagement.

## Contributing

Issues and focused pull requests are welcome, especially improvements to validation, error handling, configurable recursion limits, and output naming.
