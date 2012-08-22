* [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents)
    * Catch-all location for emailed files, direct-link PML pointers, and the files that result from the following directories.
    * [documents/manual/](https://github.com/timrdf/plunk/tree/master/instances/documents/manual)*.ttl pointers to individual documents.

The following directories contain pointers to PML and intermediate materials that result in instances in [documents/](https://github.com/timrdf/plunk/tree/master/instances/documents).
* [web-directories](https://github.com/timrdf/plunk/tree/master/instances/web-directories)
    * Uses `wget` on a `pmlp:Website` to fetch files.
* [sparql-listings](https://github.com/timrdf/plunk/tree/master/instances/sparql-listings)
    * Uses `*.rq` queries against the SPARQL endpoint in `*.ep` to obtain PML file URLs encoded in SPARQL XML Bindings.
* [sparql-listing-results-in-pml](https://github.com/timrdf/plunk/tree/master/instances/sparql-listing-results-in-pml)
    * SPARQL-queries for PML-encoded query results. (From UTEP-land; need special non-recommendation handling for this)

Uncommitted working materials:
* analyses
* local
* local-triple-store-cache
* readme.md
* us-uk alias

TODO: reconcile with YA new listing at http://inference-web.org/wiki/Mapping_PML_2.0_to_PROV#Instance_gathering
