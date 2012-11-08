#!/bin/bash
#
# Note: -w not needed b/c they hash into a file corresponding to the URL.
#

export CLASSPATH=$CLASSPATH`../../bin/pl-situate-classpath.sh`
sparql="java -Xmx2048m edu.rpi.tw.data.rdf.utils.pipes.stops.SPARQL"

dryrun="true"
if [[ "$1" == "--write" || "$1" == "-w" ]]; then
   dryrun="false"
fi

pre='[] void:dumpFile <'
post='>; a pmlp:Document .'

for rdf in `find source -name "*.rdf" -o -name "*.ttl" -o -name "*.nt"`; do
   for answer in `rapper -q -g -o ntriples $rdf | $sparql ../../../plunk/bin/rq/pmlj-hasAnswer.rq`; do
      url_md5=`md5.sh -qs $answer`

      listing="../documents/automatic/sparql-listing-in-pml-$url_md5.ttl"
      abbreviated=`echo $answer | sed 's/\(\/\/[^\/]*\/\).*\//\1...\//'`
      echo "$abbreviated now described in $listing"

      if [ "$dryrun" != "true" ]; then
         echo '@prefix void: <http://rdfs.org/ns/void#> .'                          > $listing
         echo '@prefix pmlp: <http://inference-web.org/2.0/pml-provenance.owl#> .' >> $listing
         echo                                                                      >> $listing
         echo $pre${answer}$post                                                   >> $listing
      fi
   done
done

if [ "$dryrun" == "true" ]; then
   echo
   echo "NOTE: this was a dryrun only, to write files, use --write flag"
   echo
fi
