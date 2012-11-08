#!/bin/bash
#
# Usage:
#   export CLASSPATH=$CLASSPATH`$CSV2RDF4LOD_HOME/bin/util/cr-situate-classpaths.sh`
#   (can be repeated indefinately, once paths are in PATH, nothing is returned.)

plunk=$(cd ${0%/*} && echo ${PWD%/*})

if [ "$1" == "--help" ]; then
   echo "`basename $0` [--help] [-v] [--export]"
   echo
   echo "Put them there by executing:"
   echo
   echo "    export CLASSPATH=\$CLASSPATH\`$plunk/bin/${0##*/}\`"
   exit
fi

verbose="false"
if [[ "$1" == "-v" || "$1" == "--verbose" ]]; then
   verbose="true"
   shift
fi

export="false"
if [[ "$1" == "-e" || "$1" == "--export" ]]; then
   export="true"
   shift
fi


missing=""

# Java dependencies
for jar in `find $plunk/lib -name "*.jar"`; do
   if [[ $CLASSPATH != *`basename $jar`* ]]; then
      if [ "$verbose" == "true" ]; then
         echo "`basename $jar` not in classpath; adding $plunk/$jar"
      fi
      missing=$missing:$jar
   fi
done
# for jar in `echo $CLASSPATH | sed 's/:/ /g'`; do echo $jar; jar -tf $jar | grep SPARQL; echo ; done

if [[ ${#missing} -gt 0 ]]; then
   if [[ "$export" == "true" ]]; then
      export CLASSPATH="${CLASSPATH}${missing}"
   else
      echo $missing
   fi
fi

#echo >&2
#if [ ${#missing} -eq 0 ]; then
#   echo "Good job. Now all classpaths that csv2rdf4lod-automation needs are on CLASSPATH." >&2
#   echo ${#missing}
#else
#   echo "^^ These classpaths are required by csv2rdf4lod-automation, but are NOT in CLASSPATH." >&2
#   echo >&2
#   echo "Put them there by executing:" >&2
#   echo >&2
#   echo "    export CLASSPATH=\$CLASSPATH:\`\$CSV2RDF4LOD_HOME/bin/util/cr-situate-classpaths.sh\`" >&2
#fi
