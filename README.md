## DNS CHECK

Allows you to check the DNS of multiple domains. Currently queries:
* NameServer(s)
* A-record(s)
* MX-record(s)

using Google DNS and Open DNS.

## Usage
After adding at least 1 domain to the domainlist.txt file, run from the command line:
```
sh check_dns.sh
```
or optionally output the result to a file:
```
sh check_dns.sh > result.txt
```
