```
   ██╗   ██╗██████╗ ██╗     ██████╗ ██╗   ██╗███████╗████████╗███████╗██████╗
   ██║   ██║██╔══██╗██║     ██╔══██╗██║   ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗
   ██║   ██║██████╔╝██║     ██████╔╝██║   ██║███████╗   ██║   █████╗  ██████╔╝
   ██║   ██║██╔══██╗██║     ██╔══██╗██║   ██║╚════██║   ██║   ██╔══╝  ██╔══██╗
   ╚██████╔╝██║  ██║███████╗██████╔╝╚██████╔╝███████║   ██║   ███████╗██║  ██║
    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
```

[![](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![PyPI](https://img.shields.io/pypi/v/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Status](https://img.shields.io/pypi/status/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Format](https://img.shields.io/pypi/format/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Implementation](https://img.shields.io/pypi/implementation/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - License](https://img.shields.io/pypi/l/urlbuster)](https://pypi.org/project/urlbuster/)

[![Build Status](https://github.com/cytopia/urlbuster/workflows/linting/badge.svg)](https://github.com/cytopia/urlbuster/actions?workflow=linting)
[![Build Status](https://github.com/cytopia/urlbuster/workflows/building/badge.svg)](https://github.com/cytopia/urlbuster/actions?workflow=building)
[![Build Status](https://github.com/cytopia/urlbuster/workflows/testing/badge.svg)](https://github.com/cytopia/urlbuster/actions?workflow=testing)


Powerful web directory fuzzer to locate existing and/or hidden files or directories.

Similar to [dirb](http://dirb.sourceforge.net/) or [gobuster](https://github.com/OJ/gobuster), but
with a lot of mutation options.


## Features

* Proxy support
* Cookie support
* Basic Auth
* Digest Auth
* Retries (for slow servers)
* Persistent and non-persistent HTTP connection
* Request methods: GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS
* Custom HTTP header
* Mutate POST, PUT and PATCH payloads
* Mutate with different request methods
* Mutate with different HTTP headers
* Mutate with different file extensions
* Mutate with and without trailing slashes
* Enumerate GET parameter values


## Installation
```bash
pip install urlbuster
```


## Usage
```
usage: urlbuster [options] -w <str>/-W <file> BASE_URL
       urlbuster -V, --help
       urlbuster -h, --version

URL bruteforcer to locate existing and/or hidden files or directories.

Similar to dirb or gobuster, but also allows to iterate over multiple HTTP request methods,
multiple useragents and multiple host header values.

positional arguments:
  BASE_URL              The base URL to scan.

required arguments:
  -w str, --word str    Word to use.
  -W f, --wordlist f    Path to wordlist to use.

optional global arguments:
  -n, --new             Use a new connection for every request.
                        If not specified persistent http connection will be used for all requests.
                        Note, using a new connection will decrease performance,
                        but ensure to have a clean state on every request.
                        A persistent connection on the other hand will use any additional cookie values
                        it has received from a previous request.
  -f, --follow          Follow redirects.
  -k, --insecure        Do not verify TLS certificates.
  -v, --verbose         Show also missed URLs.
  --code str [str ...]  HTTP status code to treat as success.
                        You can use a '.' (dot) as a wildcard.
                        Default: 2.. 3.. 403 407 411 426 429 500 505 511
  --payload p [p ...]   POST, PUT and PATCH payloads for all requests.
                        Note, multiple values are allowed for multiple payloads.
                        Note, if duplicates are specified, the last one will overwrite.
                        See --mpayload for mutations.
                        Format: <key>=<val> [<key>=<val>]
  --header h [h ...]    Custom http header string to add to all requests.
                        Note, multiple values are allowed for multiple headers.
                        Note, if duplicates are specified, the last one will overwrite.
                        See --mheaders for mutations.
                        Format: <key>:<val> [<key>:<val>]
  --cookie c [c ...]    Cookie string to add to all requests.
                        Format: <key>=<val> [<key>=<val>]
  --proxy str           Use a proxy for all requests.
                        Format: http://<host>:<port>
                        Format: http://<user>:<pass>@<host>:<port>
                        Format: https://<host>:<port>
                        Format: https://<user>:<pass>@<host>:<port>
                        Format: socks5://<host>:<port>
                        Format: socks5://<user>:<pass>@<host>:<port>
  --auth-basic str      Use basic authentication for all requests.
                        Format: <user>:<pass>
  --auth-digest str     Use digest authentication for all requests.
                        Format: <user>:<pass>
  --timeout sec         Connection timeout in seconds for each request.
                        Default: 5.0
  --retry num           Connection retries per request.
                        Default: 3
  --delay sec           Delay between requests to not flood the server.
  --output file         Output file to write results to.

optional mutating arguments:
  The following arguments will increase the total number of requests to be made by
  applying various mutations and testing each mutation on a separate request.

  --method m [m ...]    List of HTTP methods to test each request against.
                        Note, each supplied method will double the number of requests.
                        Supported methods: GET POST PUT DELETE PATCH HEAD OPTIONS
                        Default: GET
  --mpayload p [p ...]  POST, PUT and PATCH payloads to mutate all requests..
                        Note, multiple values are allowed for multiple payloads.
                        Format: <key>=<val> [<key>=<val>]
  --mheader h [h ...]   Custom http header string to add to mutate all requests.
                        Note, multiple values are allowed for multiple headers.
                        Format: <key>:<val> [<key>:<val>]
  --ext ext [ext ...]   List of file extensions to to add to words for testing.
                        Note, each supplied extension will double the number of requests.
                        Format: .zip [.pem]
  --slash str           Append or omit a trailing slash to URLs to test.
                        Note, a slash will be added after the extensions if they are specified as well.
                        Note, using 'both' will double the number of requests.
                        Options: both, yes, no
                        Default: no

misc arguments:
  -h, --help            Show this help message and exit
  -V, --version         Show version information

examples

  urlbuster -W /path/to/words http://example.com/
  urlbuster -W /path/to/words http://example.com:8000/
  urlbuster -k -W /path/to/words https://example.com:10000/
```


## Mutation example

Some websites behave differently for the same path depending on the specified useragent.

```bash
$ urlbuster \
  -W /usr/share/dirb/wordlists/common.txt \
  --mheader 'User-Agent:Googlebot/2.1 (+http://www.googlebot.com/bot.html)' \
  --method 'POST,GET,DELETE,PUT,PATCH' \
  http://www.domain.tld/
```

```
   ██╗   ██╗██████╗ ██╗     ██████╗ ██╗   ██╗███████╗████████╗███████╗██████╗
   ██║   ██║██╔══██╗██║     ██╔══██╗██║   ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗
   ██║   ██║██████╔╝██║     ██████╔╝██║   ██║███████╗   ██║   █████╗  ██████╔╝
   ██║   ██║██╔══██╗██║     ██╔══██╗██║   ██║╚════██║   ██║   ██╔══╝  ██╔══██╗
   ╚██████╔╝██║  ██║███████╗██████╔╝╚██████╔╝███████║   ██║   ███████╗██║  ██║
    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝

                               0.5.0 by cytopia

      SETTINGS
            Base URL:          https://www.everythingcli.org/
            Valid codes:       2.., 3.., 403, 407, 411, 426, 429, 500, 505, 511
            Connection:        Non-persistent
            Redirects:         Don't follow
            Payloads:          None
            Timeout:           5.0s
            Retries:           3
            Delay:             None

      MUTATIONS
            Mutating headers:  2
            Mutating payloads: 0 (POST)
            Methods:           5 (POST, GET, DELETE, PUT, PATCH)
            Slashes:           no
            Extensions:        1 (empty extension)
            Words:             4614

      TOTAL REQUESTS: 46140
      START TIME:     2020-01-29 08:52:12


--------------------------------------------------------------------------------
Connection:      keep-alive
Accept-Encoding: gzip, deflate
Accept:          */*
User-Agent:      python-requests/2.22.0

[301] [GET]      http://domain.tld/robots.txt

--------------------------------------------------------------------------------
Connection:      keep-alive
Accept-Encoding: gzip, deflate
Accept:          */*
User-Agent:      Googlebot/2.1 (+http://www.googlebot.com/bot.html)

[200] [GET]      http://domain.tld/robots.txt
[301] [POST]     http://domain.tld/robots.txt
[301] [GET]      http://domain.tld/robots.txt
[301] [DELETE]   http://domain.tld/robots.txt
[301] [PUT]      http://domain.tld/robots.txt
[301] [PATCH]    http://domain.tld/robots.txt
```


## Examples

### Default usage

#### Basic
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  http://www.domain.tld/
```
#### Proxy through Burpsuite
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --proxy 'http://localhost:8080' \
  http://www.domain.tld/
```
#### Save results to file
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --output out.txt \
  http://www.domain.tld/
```
#### Scan behind Basic Auth
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --auth-basic 'user:pass' \
  http://www.domain.tld/
```
#### Use session cookie
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --cookie 'PHPSESSID=a79b00e7-035a-2bb4-352a-439d855feabf' \
  http://www.domain.tld/
```


### Find files

#### Find files in root directory
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --code 200 301 302 \
  --ext .zip .tar .tar.gz .gz .rar \
  http://www.domain.tld/
```
#### Find files in sub directory
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --code 200 301 302 \
  --ext .zip .tar .tar.gz .gz .rar \
  http://www.domain.tld/wp-content/
```


### Advanced usage

#### Bruteforce query parameter
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --method GET \
  --code 200 301 302 \
  http://www.domain.tld/search?q=
```
#### Bruteforce POST requests
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --code 200 301 302 \
  --method POST \
  --payload \
    'user=somename' \
    'pass=somepass' \
    'mail=some@mail.tld' \
    'submit=yes' \
  http://www.domain.tld/
```
#### Bruteforce mutated POST requests
```bash
$ urlbuster \
  -w index.php \
  --code 200 301 302 \
  --method POST \
  --mpayload \
    'user=somename1' \
    'user=somename2' \
    'user=somename3' \
    'pass=somepass1' \
    'pass=somepass2' \
    'pass=somepass3' \
    'mail=some@mail1.tld' \
    'mail=some@mail2.tld' \
    'mail=some@mail3.tld' \
    'submit=yes' \
  http://www.domain.tld/wp-admin/
```
#### Useragent SQL injections
```bash
$ urlbuster \
  -W /path/to/wordlist.txt \
  --code 5.. \
  --method GET POST \
  --mheader \
    "User-Agent: ;" \
    "User-Agent: ' or \"" \
    "User-Agent: -- or #" \
    "User-Agent: ' OR '1" \
    "User-Agent: ' OR 1 -- -" \
    "User-Agent: \" OR 1 = 1 -- -" \
    "User-Agent: '='" \
    "User-Agent: 'LIKE'" \
    "User-Agent: '=0--+" \
    "User-Agent:  OR 1=1" \
    "User-Agent: ' OR 'x'='x" \
    "User-Agent: ' AND id IS NULL; --" \
  http://www.domain.tld/
```
#### Find potential vhosts
```bash
$ urlbuster \
  -w / \
  --method GET POST \
  --mheader \
    "Host: internal1.lan" \
    "Host: internal2.lan" \
    "Host: internal3.lan" \
    "Host: internal4.lan" \
    "Host: internal5.lan" \
    "Host: internal6.lan" \
  http://10.0.0.1
```


## Disclaimer

This tool may be used for legal purposes only. Users take full responsibility for any actions performed using this tool. The author accepts no liability for damage caused by this tool. If these terms are not acceptable to you, then do not use this tool.


## License

**[MIT License](LICENSE.txt)**

Copyright (c) 2020 **[cytopia](https://github.com/cytopia)**
