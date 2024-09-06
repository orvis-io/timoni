#!/bin/bash

for d in $(ls -d */ | sed 's#/##') ; do
    timoni mod push ./$d oci://127.0.0.1:5000/cuemodules/orvis.io/core/modules/$d --version=$1
done
