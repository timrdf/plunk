#!/bin/bash

export CLASSPATH=$CLASSPATH`../../bin/pl-situate-classpath.sh`

see='https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set'
export CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see $see"}
export CLASSPATH=$CLASSPATH`$CSV2RDF4LOD_HOME/bin/util/cr-situate-classpaths.sh`

sparql="java -Xmx2048m edu.rpi.tw.data.rdf.utils.pipes.stops.SPARQL"
sparql="java           edu.rpi.tw.data.rdf.utils.pipes.stops.SPARQL"

dryrun="true"
if [[ "$1" == "--write" || "$1" == "-w" ]]; then
   dryrun="false"
fi

# -f not avail. on ubuntu: let total=`find -f automatic manual -name "*.ttl" | wc -l | awk '{printf("%s",$1)}'`
let total=`find . -mindepth 1 -maxdepth 2 -name "*.ttl" | sed 's/^\.\///' | grep -E "^manual|^automatic" | wc -l | awk '{printf("%s",$1)}'`
echo $total

let "d=0"
# -f not avail. on ubuntu: for listing in `find -f automatic manual -name "*.ttl" | $CSV2RDF4LOD_HOME/bin/util/randomize-line-order.py`; do
for listing in `find . -mindepth 1 -maxdepth 2 -name "*.ttl" | sed 's/^\.\///' | grep -E "^manual|^automatic" | $CSV2RDF4LOD_HOME/bin/util/randomize-line-order.py`; do
   let "d=d+1"

   documents=`rapper -q -g -o ntriples $listing | $sparql ../../bin/rq/documents.rq 2> /dev/null`

   #echo $listing describes $documents

   for document in $documents; do
      if [[ $document =~ http* ]]; then # Make sure http:// URI
         document=${document%#*}                             # Strip off the fragment identifier.
         local=`echo $document | perl -pi -e 's|http?://||'` # Strip off the protocol
         if [ ! -e source ]; then
            mkdir source
         fi
         pushd source &> /dev/null
            if [ ! -e $local ]; then 
               if [ "$dryrun" != "true" ]; then
                  echo "$d/$total $document"
                  wget --mirror -e robots=off --no-parent $document
                  echo $document > $local.sd_name &> /dev/null
               else
                  echo "$d/$total $document" 
                  space="`echo $d/$total | sed 's/./ /g'` "
                  echo "$space^-- wget --mirror -e robots=off --no-parent"
                  echo "$space $local"
                  echo
               fi
            else
               echo "$d/$total -- skipping -- $document"
            fi
         popd &> /dev/null
      else
         echo "WARNING: not an HTTP URI: $document"
      fi
   done
done

if [ "$dryrun" == "true" ]; then
   echo
   echo "NOTE: this was a dryrun only, to write files, use --write flag"
   echo
fi
