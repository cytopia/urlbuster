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
#URL="https://www.google.com/search?q="
URL_FOLLOW="https://google.com/search?q="


# -------------------------------------------------------------------------------------------------
# START
# -------------------------------------------------------------------------------------------------

###
### Default + Redirects: nofollow
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL_FOLLOW}" --code 301 302
check_setting "${OUT}" "Base URL" "${URL_FOLLOW}" "1"
check_setting "${OUT}" "Valid codes" "301, 302" "1"
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
### Default + Redirects: follow
###
"${BINARY}" -W "${WORD}" --output "${OUT}" "${URL_FOLLOW}" --follow --code 200
check_setting "${OUT}" "Base URL" "${URL_FOLLOW}" "1"
check_setting "${OUT}" "Valid codes" "200" "1"
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
