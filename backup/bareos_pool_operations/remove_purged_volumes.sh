#!/usr/bin/env bash


# ------------------------------------------------------------------------ #
# Removes all volumes physically from the disk which are in 'purged' state #
#   Written by Alexander Bazhenov December, 2018. Updated December, 2021.  #
# ------------------------------------------------------------------------ #

# This Source Code Form is subject to the terms of the MIT License. If a
# copy of the MPL was not distributed with this file, You can obtain one at:
# https://github.com/alexanderbazhenoff/data-scripts/blob/master/LICENSE


for F in $(echo "list volume" | bconsole | grep Purged | cut -d ' ' -f6)
do
  echo "delete volume=$F yes" | bconsole
  rm -rf /mnt/nas/"$F"
done

