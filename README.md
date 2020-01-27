# urlbuster


[![](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![PyPI](https://img.shields.io/pypi/v/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Status](https://img.shields.io/pypi/status/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Format](https://img.shields.io/pypi/format/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - Implementation](https://img.shields.io/pypi/implementation/urlbuster)](https://pypi.org/project/urlbuster/)
[![PyPI - License](https://img.shields.io/pypi/l/urlbuster)](https://pypi.org/project/urlbuster/)

[![Build Status](https://github.com/cytopia/urlbuster/workflows/linting/badge.svg)](https://github.com/cytopia/urlbuster/actions?workflow=linting)
[![Build Status](https://github.com/cytopia/urlbuster/workflows/building/badge.svg)](https://github.com/cytopia/urlbuster/actions?workflow=building)


URL bruteforcer to locate existing and/or hidden files or directories.

Similar to [dirb](http://dirb.sourceforge.net/) or [gobuster](https://github.com/OJ/gobuster), but also allows to iterate over multiple HTTP request methods,
multiple useragents and multiple host headers.


## Features

* Proxy support
* Basic Auth support
* Digest Auth support
* Persistent HTTP connection
* Test different request methods
* Test different user agents
* Test different host header values
* Test with and without a trailing slash
* Enumerate GET parameter values


## Installation
```bash
pip install urlbuster
```

## Usage
```
usage: urlbuster [options] -w <word>/-W <path> BASE_URL
       urlbuster --help
       urlbuster --version

URL bruteforcer to locate existing and/or hidden files or directories.

Similar to dirb or gobuster, but also allows to iterate over multiple HTTP request methods,
multiple useragents and multiple host header values.

positional arguments:
  BASE_URL              The base URL to scan.

required arguments:
  -w str, --word str    Word to use.
  -W f, --wordlist f    Path to wordlist to use.

optional arguments:
  -c str, --code str    Comma separated list of HTTP status code to treat as success.
                        You can use a '.' (dot) as a wildcard.

                        Default: 2.., 3.., 403, 407, 411, 426, 429, 500, 505, 511
  -m str, --method str  Comma separated list of HTTP methods to test against each request.
                        Note, each supplied method will double the number of requests.
                        Supported methods: GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS
                        Default: GET
  -s str, --slash str   Append or omit a trailing slash to URLs to test.
                        Options: both, yes, no
                        Note, using 'both' will double the number of requests.
                        Default: no
  -a str, --agent str   Useragent string to send.
  -A f, --agent-file f  Path to a newline separated file of useragents to use.
                        Note, each supplied useragent will double the number of requests.
  -h str, --host str    Host header value to send.
  -H f, --host-file f   Path to a newline separated file of host header values to send.
                        Note, each supplied host header value will double the number of requests.
  -n, --new             Use a new connection for every request.
                        If not specified persistent http connection will be used for all requests.
  -k, --insecure        Do not verify TLS certificates.
  -b str, --auth-basic str
                        Use basic authentication for all requests.
                        Format: <user>:<pass>
  -d str, --auth-digest str
                        Use digest authentication for all requests.
                        Format: <user>:<pass>
  -p str, --proxy str   Use a proxy for all requests.
                        Format: http://<host>:<port>
                        Format: http://<user>:<pass>@<host>:<port>
  -t s, --timeout s     Connection timeout in seconds.
                        Default: 5
  -r x, --retries x     Connection retries.
                        Default: 3
  --help                Show this help message and exit
  --version             Show version information

examples

  urlbuster -w /path/to/words http://example.com
  urlbuster -w /path/to/words http://example.com:8000
  urlbuster -k -w /path/to/words https://example.com:10000
```


## Examples

### Different useragents

Some websites behave differently for the same path depending on the specified useragent.

```bash
$ urlbuster \
  -W /usr/share/dirb/wordlists/common.txt \
  -A /usr/share/urlbuster/examples/useragents-basic.txt \
  -m 'POST,GET,DELETE,PUT,PATCH' \
  http://www.domain.tld/
```

```
   db    db d8888b. db      d8888b. db    db .d8888. d888888b d88888b d8888b.
   88    88 88  `8D 88      88  `8D 88    88 88'  YP `~~88~~' 88'     88  `8D
   88    88 88oobY' 88      88oooY' 88    88 `8bo.      88    88ooooo 88oobY'
   88    88 88`8b   88      88~~~b. 88    88   `Y8b.    88    88~~~~~ 88`8b
   88b  d88 88 `88. 88booo. 88   8D 88b  d88 db   8D    88    88.     88 `88.
   ~Y8888P' 88   YD Y88888P Y8888P' ~Y8888P' `8888Y'    YP    Y88888P 88   YD

                               0.3.0 by cytopia

      SETTINGS
            Base URL:       http://www.domain.tld/
            Timeout:        5s
            Retries:        3
            Valid codes:    2.., 3.., 403, 407, 411, 426, 429, 500, 505, 511

      DEFAULT HEADERS
            Accept-Encoding: gzip, deflate
            Accept: */*
            Connection: keep-alive

      MUTATIONS
            Useragents:     2
            Host headers:   0
            Methods:        5 (POST, GET, DELETE, PUT, PATCH)
            Add slashes:    no
            Words:          4614

      TOTAL REQUESTS: 46140

################################################################################
[HEADER] User-Agent: Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
################################################################################
[200] [GET]    http://domain.tld/robots.txt

################################################################################
[HEADER] User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25
################################################################################
[301] [POST]   http://domain.tld/robots.txt
[301] [GET]    http://domain.tld/robots.txt
[301] [DELETE] http://domain.tld/robots.txt
[301] [PUT]    http://domain.tld/robots.txt
[301] [PATCH]  http://domain.tld/robots.txt
```


## Disclaimer

This tool may be used for legal purposes only. Users take full responsibility for any actions performed using this tool. The author accepts no liability for damage caused by this tool. If these terms are not acceptable to you, then do not use this tool.


## License

**[MIT License](LICENSE.txt)**

Copyright (c) 2020 **[cytopia](https://github.com/cytopia)**
