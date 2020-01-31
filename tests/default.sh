#!/usr/bin/env bash

set -e
set -u
set -o pipefail

CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# shellcheck disable=SC1090
. "${CWD}/.lib.sh"


# -------------------------------------------------------------------------------------------------
# VARIABLES
# -------------------------------------------------------------------------------------------------
WORD="${CWD}/words/words.txt"
OUT="${CWD}/output/run.txt"
URL="https://www.google.com/search?q="


# -------------------------------------------------------------------------------------------------
# SETTINGS
# -------------------------------------------------------------------------------------------------

###
### Default
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}"
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Codes
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --code 200 301 302
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "200, 301, 302" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + HTTP Connection
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --new
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "Non-persistent" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Redirects: follow
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --follow
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "Follow" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Insecure
###
HOST="www.google.com"
ADDRESS="$( host  "${HOST}" | grep 'has address' | grep -Eo '[0-9][.0-9]+' )"
URL_INS="https://${ADDRESS}/search?q="
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL_INS}" --insecure
check_setting "${OUT}" "Base URL" "${URL_INS}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Header: User-Agent
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --header 'User-Agent: Chrome'
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "Chrome" "1"
check_error "${OUT}"


###
### Default + Payloads
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --method GET POST --payload 'username=johndoe'
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "username=johndoe" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "2 (POST)" "1"
check_setting "${OUT}" "Methods" "2 (GET, POST)" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "$(( DEFAULT_TOTAL_REQUESTS * 2 ))" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Cookie
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --cookie somekey=someval
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Cookies" "somekey=someval" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Proxy
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --proxy 'http://localhost:8080'
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Proxy" "http://localhost:8080" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}" "1"


###
### Default + Auth basic
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --auth-basic 'username:password'
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Basic auth" "username:password" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Auth digest
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --auth-digest 'username:password'
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Digest auth" "username:password" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Timeout
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --timeout 30
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "30.0s" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Retries
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --retry 10
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "10" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Delay
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --delay 1
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "1.0s" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


# -------------------------------------------------------------------------------------------------
# MUTATIONS
# -------------------------------------------------------------------------------------------------

# mheader
# mpayload
# methods


###
### Default + Slashes == yes
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --slash yes
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "yes" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "${DEFAULT_TOTAL_REQUESTS}" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Slashes == both
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --slash both
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "both" "1"
check_setting "${OUT}" "Extensions" "${DEFAULT_EXT}" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "$(( DEFAULT_TOTAL_REQUESTS * 2))" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"


###
### Default + Extensions
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL}" --ext .zip .tar
check_setting "${OUT}" "Base URL" "${URL}" "1"
check_setting "${OUT}" "Valid codes" "${DEFAULT_CODES}" "1"
check_setting "${OUT}" "HTTP Connection" "${DEFAULT_CONN}" "1"
check_setting "${OUT}" "Redirects" "${DEFAULT_REDIR}" "1"
check_setting "${OUT}" "Payloads" "${DEFAULT_PAYLOADS}" "1"
check_setting "${OUT}" "Timeout" "${DEFAULT_TIMEOUT}" "1"
check_setting "${OUT}" "Retries" "${DEFAULT_RETRIES}" "1"
check_setting "${OUT}" "Delay" "${DEFAULT_DELAY}" "1"
check_setting "${OUT}" "Mutating headers" "${DEFAULT_MUT_HEADERS}" "1"
check_setting "${OUT}" "Mutating payloads" "${DEFAULT_MUT_PAYLOADS}" "1"
check_setting "${OUT}" "Methods" "${DEFAULT_METHODS}" "1"
check_setting "${OUT}" "Slashes" "${DEFAULT_SLASHES}" "1"
check_setting "${OUT}" "Extensions" "2 (\".zip\", \".tar\")" "1"
check_setting "${OUT}" "Words" "${DEFAULT_WORD}" "1"
check_setting "${OUT}" "TOTAL REQUESTS" "$(( DEFAULT_TOTAL_REQUESTS * 2 ))" "1"

check_setting "${OUT}" "Connection" "${DEFAULT_H_CONNECTION}" "1"
check_setting "${OUT}" "Accept-Encoding" "${DEFAULT_H_ACCEPT_ENC}" "1"
check_setting "${OUT}" "Accept" "${DEFAULT_H_ACCEPT}" "1"
check_setting "${OUT}" "User-Agent" "${DEFAULT_H_AGENT}" "0"
check_error "${OUT}"
