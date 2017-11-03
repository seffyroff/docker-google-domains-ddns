#!/bin/bash

# Requirements:
#   ${USER_AGENT} - Set within "docker run".
#   ${USERNMAE} - Set within "docker run".
#   ${PASSWORD} - Set within "docker run".
#   ${HOSTNAME}- Set within "docker run".
#   ${INTERVAL} - Set within "docker run".
#   - INTERVAL must be a number followed by m, h, or d. Example: 5m
#   - INTERVAL must not be less than 5 minutes.

#-----------------------------------------------------------------------------------------------------------------------
# Functions:

log_time () {
  echo [`date '+%b %d %X'`]
}

#-----------------------------------------------------------------------------------------------------------------------
# Exection order:

while true
do

  # Google API will use the IP from where the curl request is submitted from

  RESPONSE=$(curl -S -s -k --user-agent "${USER_AGENT}" -u "${USERNAME}:${PASSWORD}" "https://domains.google.com/nic/update?hostname=${HOSTNAME}" 2>&1)

  # Sometimes the API returns "nochg" without a space and ip address. It does this even if the password is incorrect.
  if [[ ${RESPONSE} =~ ^(good|nochg) ]] ; then
    echo "${log_tim} Google Domains successfully called. Result was \"${RESPONSE}\"."

  # Check for an error code

  elif [[ ${RESPONSE} =~ ^(nohost|badauth|badagent|abuse|notfqdn) ]] ; then
    echo "${log_tim} Something went wrong. Check your settings. Result was \"${RESPONSE}\"."
    echo "${log_tim} For an explanation of error codes, see https://support.google.com/domains/answer/6147083"
    exit 2

  # Check for error 911

  elif [[ ${RESPONSE} =~ ^911 ]] ; then
    echo "${log_tim} Server returned "911". Waiting for 30 minutes before trying again."
    sleep 1800
    continue

  # Check for "other" condition

  else
    echo "${log_tim} Couldn't update. Trying again in 5 minutes. Output from curl command was \"${RESPONSE}\"."
  fi

  # Sleep the set interval

  sleep ${INTERVAL}
done