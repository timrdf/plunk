#!/bin/bash
#
# Note: -w not needed b/c they hash into a file corresponding to the URL.
#

dryrun="true"
if [[ "$1" == "--write" || "$1" == "-w" ]]; then
   dryrun="false"
fi

pre='[] void:dumpFile <'
post='>; a pmlp:Document .'

today=`date +%Y-%m-%d`

for rq in *.rq; do
   query=${rq%.rq}

   pushd manual &> /dev/null # cache-queries.sh doesn't handle relative paths to a .rq
      # e.g. using logd:
      #
      # logd.rq - the query that should be executed.
      # logd.ep - the endpoint that logd.rq should be executed against.
      # logd.pml - associates the logd.ep that logd.rq should be executed against.

      echo cache-queries.sh `cat $query.ep` -o xml -q $query.rq -od ../source/$today

      if [ "$dryrun" != "true" ]; then
         cache-queries.sh `cat $query.ep` -o xml -q $query.rq -od ../source/$today
      fi
   popd &> /dev/null

   xsl="../../bin/srx.xsl a a"
   for result in `saxon.sh $xsl source/$today/$query.rq.xml`; do
      result=`echo $result | sed 's/void.ttl.gz$/void.ttl/'`   # <---- HACK
      result=`echo $result | sed 's/void.ttl.tgz$/void.ttl/'`  # <---- HACK
      url_md5=`md5 -qs $result`
      listing="../../documents/automatic/sparql-listing-$url_md5.ttl"

      echo "$result now described in ../documents/automatic/sparql-listing-$url_md5.ttl"

      if [ "$dryrun" != "true" ]; then
         echo '@prefix void: <http://rdfs.org/ns/void#> .'                          > $listing
         echo '@prefix pmlp: <http://inference-web.org/2.0/pml-provenance.owl#> .' >> $listing
         echo                                                                      >> $listing
         echo $pre$result$post                                                     >> $listing
      fi
   done
done

if [ "$dryrun" == "true" ]; then
   echo
   echo "NOTE: this was a dryrun only, to write files, use --write flag"
   echo
fi
