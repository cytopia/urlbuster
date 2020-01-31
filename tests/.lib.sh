#!/usr/bin/env bash

set -e
set -u
set -o pipefail


# shellcheck disable=SC2034
BINARY="$(cd -P -- "$(dirname -- "$0")/../bin/" && pwd -P)/urlbuster"
DEFAULT_CODES="2.., 3.., 403, 407, 411, 426, 429, 500, 505, 511"
DEFAULT_CONN="Persistent"
DEFAULT_REDIR="Don.t follow"
DEFAULT_PAYLOADS="None"
DEFAULT_TIMEOUT="5.0s"
DEFAULT_RETRIES="3"
DEFAULT_DELAY="None"
DEFAULT_MUT_HEADERS="1"
DEFAULT_MUT_PAYLOADS="0"
DEFAULT_METHODS="1 (GET)"
DEFAULT_SLASHES="no"
DEFAULT_EXT="1 (empty extension)"
DEFAULT_WORD="3"
DEFAULT_TOTAL_REQUESTS="3"
DEFAULT_H_CONNECTION="keep-alive"
DEFAULT_H_ACCEPT_ENC="gzip, deflate"
DEFAULT_H_ACCEPT="\*/\*"
DEFAULT_H_AGENT="python-requests/"



###
### Run
###
function run() {
	local cmd="${1}"
	local to_stderr=0

	# Output to stderr instead?
	if [ "${#}" -eq "2" ]; then
		to_stderr="${2}"
	fi

	local red="\\033[0;31m"
	local green="\\033[0;32m"
	local yellow="\\033[0;33m"
	local reset="\\033[0m"

	if [ "${to_stderr}" -eq "0" ]; then
		printf "${yellow}[%s] ${red}%s \$ ${green}${cmd}${reset}\\n" "$(hostname)" "$(whoami)"
	else
		printf "${yellow}[%s] ${red}%s \$ ${green}${cmd}${reset}\\n" "$(hostname)" "$(whoami)" >&2
	fi

	if sh -c "${cmd}"; then
		if [ "${to_stderr}" -eq "0" ]; then
			printf "${green}[%s]${reset}\\n" "OK"
		else
			printf "${green}[%s]${reset}\\n" "OK" >&2
		fi
		return 0
	else
		if [ "${to_stderr}" -eq "0" ]; then
			printf "${red}[%s]${reset}\\n" "NO"
		else
			printf "${red}[%s]${reset}\\n" "NO" >&2
		fi
		return 1
	fi
}
###
### Run (must fail in order to succeed)
###
function run_fail() {
	local cmd="${1}"
	local to_stderr=0

	# Output to stderr instead?
	if [ "${#}" -eq "2" ]; then
		to_stderr="${2}"
	fi

	local red="\\033[0;31m"
	local green="\\033[0;32m"
	local yellow="\\033[0;33m"
	local reset="\\033[0m"

	if [ "${to_stderr}" -eq "0" ]; then
		printf "${yellow}[%s] ${red}%s \$ ${yellow}[NOT] ${green}${cmd}${reset}\\n" "$(hostname)" "$(whoami)"
	else
		printf "${yellow}[%s] ${red}%s \$ ${yellow}[NOT] ${green}${cmd}${reset}\\n" "$(hostname)" "$(whoami)" >&2
	fi

	if ! sh -c "${cmd}"; then
		if [ "${to_stderr}" -eq "0" ]; then
			printf "${green}[%s]${reset}\\n" "OK"
		else
			printf "${green}[%s]${reset}\\n" "OK" >&2
		fi
		return 0
	else
		if [ "${to_stderr}" -eq "0" ]; then
			printf "${red}[%s]${reset}\\n" "NO"
		else
			printf "${red}[%s]${reset}\\n" "NO" >&2
		fi
		return 1
	fi
}


function check_setting() {
	local outfile="${1}"
	local setting="${2}"
	local expect="${3}"
	local exact="${4:-0}"

	if [ "${exact}" -eq "1" ]; then
		run "grep -F '${setting}' '${outfile}' | sed 's/.*${setting}:[[:space:]]*//g' | grep '^${expect}\$'"
	else
		run "grep -F '${setting}' '${outfile}' | sed 's/.*${setting}:[[:space:]]*//g' | grep '${expect}'"
	fi
}

function check_error() {
	local outfile="${1}"
	local revert="${2:-0}"

	if [ "${revert}" -eq "1" ]; then
		run "grep '\\[ERR\\]' '${outfile}'"
	else
		run_fail "grep '\\[ERR\\]' '${outfile}'"
	fi
}
