#!/usr/bin/env bash


### md5 checksum calculation for $SOURCE_PATH
###
### -----------------------------------------------------------------------------------------------
### Warning! Running this file you accept that you know what you're doing. All actions with this
###          script at your own risk.
### -----------------------------------------------------------------------------------------------
### This Source Code Form is subject to the terms of the MIT License. If a copy of the MPL was not
### distributed with this file, You can obtain one at https://github.com/aws/mit-0


SOURCE_PATH="/mnt/backup/"

usage_error() {
  echo "Error: unrecognized option: $POSITIONAL"
  echo ""
  echo "Usage:"
  echo "   -s|--source|--source-path /path/to/source/folder/or/file"
  echo "                             (defaults: $SOURCE_PATH)"
  exit 1
}

check_md5() {
  FILENAME="$1"
  echo "Checking exising ${FILENAME#./}'s md5..."
  md5sum -c "$FILENAME.md5" || \
    (echo "Re-calculating md5 for $FILENAME..." && \
      md5sum -b "$FILENAME" | tee "$FILENAME".md5)
}

while [[ $# -gt 0 ]]; do
  KEY="$1"

  case $KEY in
  -s | --source | --source-path)
    SOURCE_PATH="$2"
    shift
    shift
    ;;

  *)                   # unknown option
    POSITIONAL+=("$1")
    usage_error
    shift
    ;;
  esac
done

set -- "${POSITIONAL[@]}"
export -f check_md5

HOSTNAME="$(hostname)"
echo "Ready to calculate md5 checksum on $HOSTNAME for directory: $SOURCE_PATH"

find . ! -name '*.md5' -type f -exec bash -c \
  'if [[ -f $1.md5 ]]; then check_md5 $1; else md5sum -b $1 | tee $1.md5; fi' -- {} \; || \
  /./opt/scripts/check_error_notification.sh "md5" && exit 1