#!/bin/bash

pushd source &> /dev/null
   file="prov-xgs-provenance-mappings.csv"
   if [ ! -e $file ]; then
      pcurl.sh 'http://spreadsheets.google.com/tq?tqx=out:csv&tq=select%20*&key=0ArTeDpS4-nUDdFBrQ3ZJMXROUHh4SmxRUVE5V0QwbVE' -n prov-xgs-provenance-mappings -e csv
   else
      echo "skipping $file b/c it is already there"
   fi
popd &> /dev/null
