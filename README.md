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

* Test with different useragents
* Test with different host headers
* Test different request methods
* Test with and without a trailing slash
* Specify which http status code yield a successful request


## Installation
```bash
pip install urlbuster
```

## Usage
```
usage: urlbuster [options] -w <path> URL
       urlbuster --help
       urlbuster --version

URL bruteforcer to locate existing and/or hidden files or directories.

Similar to dirb or gobuster, but also allows to iterate over multiple HTTP request methods,
multiple useragents and multiple host headers.

positional arguments:
  URL                   The base URL to scan.

required arguments:
  -w f, --wordlist f    The path of the wordlist.

optional arguments:
  -c str, --code str    Comma separated list of HTTP status code to treat as success.
                        Default: 200, 204, 301, 302, 307, 403
  -m str, --method str  Comma separated list of HTTP methods to test for each request.
                        Supported methods: Note, each supplied method will double the number of requests.
                        GET, POST, PUT, DELETE, PATCH
                        Default: GET
  -s str, --slash str   Append or omit a trailing slash to URLs to test.
                        Options: both, yes, no.Note using 'both' will double the number of requests.
                        Default: no
  -a str, --agent str   Useragent header to send.
  -A f, --agent-file f  Newline separated list of useragents to use.
                        Note, each supplied useragent will double the number of requests.
  -h str, --host str    Host header to send.
  -H f, --host-file f   Newline separated list of host headers to send.
                        Note, each supplied host header will double the number of requests.
  -t s, --timeout s     Connection timeout in seconds.
                        Default: 5
  -r x, --retries x     Connection retries.
                        Default: 3
  --help                Show this help message and exit
  --version             Show version information
```


## Motivation

I came across a couple of websites that behaved differently depending on the specified useragent.
The feature of iterating over multiple specified useragents and other HTTP header values
or request methods was lacking from current tools.


```bash
$ urlbuster \
  -w /usr/share/dirb/wordlists/common.txt \
  -A /usr/share/urlbuster/examples/useragents-basic.txt \
  -m 'POST,GET,DELETE,PUT,PATCH' \
  http://domain.tld

Base URL:       http://domain.tld
Valid codes:    200, 204, 301, 302, 307, 403
Useragents:     2
Host headers:   0
Methods:        5 (POST, GET, DELETE, PUT, PATCH)
Words:          4614
Slashs:         no

Total requests: 46140

####################################################################################################
[HEADER] User-Agent: Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
####################################################################################################
[200] [GET]    http://domain.tld/robots.txt

####################################################################################################
[HEADER] User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25
####################################################################################################
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
