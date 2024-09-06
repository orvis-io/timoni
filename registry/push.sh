#!/bin/bash

for d in $(ls -d */ | sed 's#/##') ; do
    [ -L "${d%/}" ] && continue
    cd $d && cue mod publish $1 && cd ..
done
