#!/bin/bash
#                                                                              |

export CLASSPATH=$CLASSPATH`../../bin/pl-situate-classpath.sh`

dryrun="true"
if [[ "$1" == '--write' || "$1" == '-w' ]]; then
   dryrun="false"
fi

pushd source &> /dev/null

   sparql="java -Xmx2048m edu.rpi.tw.data.rdf.utils.pipes.stops.SPARQL"

   for web_directory in `rapper -q -g -o ntriples ../manual/pml-pointers.ttl | $sparql ../../../bin/rq/web-directories.rq`; do

      local_directory="${web_directory#'http://'}"
      if [ ! -d $local_directory ]; then
         if [ "$dryrun" != 'true' ]; then
            # Tim's wget:
            # -m,  --mirror             shortcut for -N -r -l inf --no-remove-listing.
            #                                        -N                                (--timestamping) don't re-retrieve files unless newer than local.
            #                                           -r                             (--recursive)    specify recursive download.
            #                                              -l                          (--level=NUMBER) maximum recursion depth (inf or 0 for infinite).
            #                                                     --no-remove-listing                   don't remove `.listing' files.
            # -e,  --execute=COMMAND    execute a `.wgetrc'-style command.
            # -A,  --accept=LIST        comma-separated list of accepted extensions.
            # -np, --no-parent          don't ascend to the parent directory.
            wget --mirror -e robots=off -A owl,rdf,ttl,nt,n3 --no-parent $web_directory

            # Jitin's wget:
            #    wget -T 5 -r -c -nH -nv --reject=.jpg,.png,.hsr,.csr,.htm,.html,.pdf,.doc,.docx,.xls,.xlsx $web_directory
            #
            # -T, --timeout=SECONDS
            # -r,  --recursive             specify recursive download.
            # -c,  --continue              resume getting a partially-downloaded file.
            # -nH, --no-host-directories   don't create host directories.
            # -nv, --no-verbose            turn off verboseness, without being quiet.
            # -R,  --reject=LIST           comma-separated list of rejected extensions.
         else
            echo "wget --mirror -e robots=off -A owl,rdf,ttl,nt,n3 --no-parent $web_directory"
         fi
      else
         echo "  -|- skipped -|- $web_directory - local directory already exists; skipping to avoid duplication."
      fi
   done
   if [ "$dryrun"} == 'true' ]; then
      echo
      echo "(run with -w or --write to invoke mirroring)"
   fi
popd &> /dev/null
