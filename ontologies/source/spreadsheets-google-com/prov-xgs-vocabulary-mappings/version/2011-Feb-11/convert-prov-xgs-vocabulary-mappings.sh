#!/bin/bash
# prov-xgs-vocabulary-mappings 2011-Feb-11 ()
#--------------------------------------------------------------

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh"}

surrogate="http://logd.tw.rpi.edu" # Came from $CSV2RDF4LOD_BASE_URI when cr-create-convert-sh.sh created this script.
sourceID="spreadsheets-google-com"
datasetID="prov-xgs-vocabulary-mappings"
datasetVersion="2011-Feb-11"        # NO SPACES; Use curl -I -L http://www.data.gov/download/prov-xgs-vocabulary-mappings/csv | grep Last-Modified: | awk '{printf(%s-%s-%s,,,)}'
eID="1"                             # enhancement identifier
if [ $# -ge 2 ]; then
   if [ $1 == "-e" ]; then
     eID="$2" 
   fi
fi


# source/prov-xgs-provenance-mappings.csv
sourceDir="source"                  # if directly from source, 'source'; if manual manipulations of source were required, 'manual'.
destDir="automatic"                 # always 'automatic'
#--------------------------------------------------------------


#-----------------------------------
datafile="prov-xgs-provenance-mappings.csv"
data="$sourceDir/$datafile"
subjectDiscriminator=               # Additional part of URI for subjects created; must be URI-ready (e.g., no spaces).
header=                             # Line that header is on; only needed if not '1'. '0' means no header.
dataStart=                          # Line that data starts; only needed if not immediately after header.
repeatAboveIfEmptyCol=              # 'Fill in' value from row above for this column.
onlyIfCol=                          # Do not process if value in this column is empty
interpretAsNull=                    # NO SPACES
dataEnd=                            # Line on which data stops; only needed if non-data bottom matter (legends, footnotes, etc).
source $CSV2RDF4LOD_HOME/bin/convert.sh


#-----------------------------------
source $CSV2RDF4LOD_HOME/bin/convert-aggregate.sh
