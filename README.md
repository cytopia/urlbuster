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


Powerful web directory fuzzer to locate existing and/or hidden files or directories.

Similar to [dirb](http://dirb.sourceforge.net/) or [gobuster](https://github.com/OJ/gobuster), but
with a lot of mutation options.


## Features

* Proxy support
* Cookie support
* Basic Auth
* Digest Auth
* Request methods: GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS
* Custom HTTP header
* Persistent and non-persistent HTTP connection
* Mutate with different request methods
* Mutate with different HTTP header
* Mutate with different file extensions
* Mutate with trailing slashes
* Enumerate GET parameter values


## Installation
```bash
pip install urlbuster
```


## Usage
```
usage: urlbuster [options] -w <str>/-W <file> BASE_URL
       urlbuster -v, --help
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
  --code str [str ...]  HTTP status code to treat as success.
                        You can use a '.' (dot) as a wildcard.
                        Default: 2.. 3.. 403 407 411 426 429 500 505 511
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
  -v, --version         Show version information

examples

  urlbuster -W /path/to/words http://example.com/
  urlbuster -W /path/to/words http://example.com:8000/
  urlbuster -k -W /path/to/words https://example.com:10000/
```


## Examples

### Different useragents

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

                               0.4.1 by cytopia

      SETTINGS
            Base URL:         http://www.domain.tld/
            Connection:       Persistent
            Valid codes:      2.., 3.., 403, 407, 411, 426, 429, 500, 505, 511
            Timeout:          5.0s
            Retries:          3
            Delay:            None

      MUTATIONS
            Mutating headers: 2
            Methods:          5 (POST, GET, DELETE, PUT, PATCH)
            Slashes:          no
            Extensions:       1 (empty extension)
            Words:            4614

      TOTAL REQUESTS: 46140
      START TIME:     2020-01-29 08:52:12


--------------------------------------------------------------------------------
Connection:      keep-alive
Accept-Encoding: gzip, deflate
Accept:          */*
User-Agent:      python-requests/2.22.0

[200] [GET]      http://domain.tld/robots.txt

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


## Disclaimer

This tool may be used for legal purposes only. Users take full responsibility for any actions performed using this tool. The author accepts no liability for damage caused by this tool. If these terms are not acceptable to you, then do not use this tool.


## License

**[MIT License](LICENSE.txt)**

Copyright (c) 2020 **[cytopia](https://github.com/cytopia)**
