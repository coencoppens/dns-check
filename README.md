## DNS CHECK

Allows you to check the DNS of one or more domains. Currently queries:
* NameServer(s)
* A-record(s)
* MX-record(s)

using Google DNS and Open DNS.

The output looks like this:
```
=========================
coencoppens.nl
=========================

  @ google-public-dns-a.google.com.:
    NS:         ns2.transip.eu., ns1.transip.nl., ns1.hosting-01.c4a.nl.
    A:          84.38.238.76
    MX:         mx.pimbox.nl.


  @ resolver1.opendns.com.:
    NS:         ns2.transip.eu., ns1.hosting-01.c4a.nl., ns1.transip.nl.
    A:          84.38.238.76
    MX:         mx.pimbox.nl.
```

## Usage

There are two ways of using the script.

### Single domain
```
sh check_dns.sh coencoppens.nl
```

### Multi domain
If you want to check multiple domains, add at least 1 domain to the domainlist.txt file. Then run from the command line:
```
sh check_dns.sh
```
or optionally output the result to a file:
```
sh check_dns.sh > result.txt
```
