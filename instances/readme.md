* [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents)
    * Catch-all location for emailed files, direct-link PML pointers, and the files that result from the following directories.
    * [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents)`source/` contains the downloaded files listed in [documents/manual/](https://github.com/timrdf/plunk/tree/master/instances/documents/manual)*.ttl and [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents/)`automatic/*.ttl`.
    * [documents/manual/](https://github.com/timrdf/plunk/tree/master/instances/documents/manual)*.ttl list pointers to individual documents.
    * [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents)`automatic/` contains files from [sparql-listings/](https://github.com/timrdf/plunk/tree/master/instances/sparql-listings) and [sparql-listing-results-in-pml/](https://github.com/timrdf/plunk/tree/master/instances/sparql-listing-results-in-pml) (see below).
* [web-directories/](https://github.com/timrdf/plunk/tree/master/instances/web-directories)
    * Uses `wget` on a `pmlp:Website` to fetch files.
    * Maintained to complement [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents) to avoid duplicating the mirrored website files.
    * [documents/](https://github.com/timrdf/plunk/tree/master/instances/web-directories)`source/` contains the mirrored files.

The following directories contain pointers to PML and intermediate materials that result in instances in [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents).

* [sparql-listings/](https://github.com/timrdf/plunk/tree/master/instances/sparql-listings)
    * Uses `*.rq` queries against the SPARQL endpoint in `*.ep` to obtain PML file URLs encoded in SPARQL XML Bindings.
    * `cd sparql-listings; ./2documents.sh -w`
    * Places listings in [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents)`automatic/*.ttl`
* [sparql-listing-results-in-pml/](https://github.com/timrdf/plunk/tree/master/instances/sparql-listing-results-in-pml)
    * SPARQL-queries for PML-encoded query results. (From UTEP-land; need special non-recommendation handling for this)
    * `cd sparql-listing-results-in-pml; ./2documents.sh -w`
    * Places listings in [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents)`automatic/*.ttl`

Uncommitted working materials:
* analyses
* local
* local-triple-store-cache
* us-uk alias

TODO: reconcile with YA new listing at http://inference-web.org/wiki/Mapping_PML_2.0_to_PROV#Instance_gathering
