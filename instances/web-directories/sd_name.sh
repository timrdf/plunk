#!/bin/bash

dryrun="true"
if [[ "$1" == "--write" || "$1" == "-w" ]]; then
   dryrun="false"
   shift
fi

for file in `find source -type f -not -name "*.sd_name"`; do
   if [[ `void-triples.sh $file` > 0 ]]; then
      if [ "$dryrun" != "true" ]; then
         echo "http://${file#source/}" > $file.sd_name
      else
         echo "adding $file.sd_name"
      fi
   else
      echo "WARNING: file did not contain triples: $file"
   fi
done
