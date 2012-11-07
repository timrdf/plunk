[plunk](https://github.com/timrdf/plunk/tree/master/bin): Some pointers to PML data and automation to grab it.

* [instances/](https://github.com/timrdf/plunk/tree/master/instances)
    * The meat of the analysis starts with this skeleton. Start here.
* [bin/](https://github.com/timrdf/plunk/tree/master/bin)
    * Executables to gather instances. Gathers according to the pointers in [instances/](https://github.com/timrdf/plunk/tree/master/instances), placing them into [instances/](https://github.com/timrdf/plunk/tree/master/instances).
* [queries/](https://github.com/timrdf/plunk/tree/master/queries)
    * Not developed.
* [ontologies/](https://github.com/timrdf/plunk/tree/master/ontologies)
    * Anscillary; not related to gathering instances.
* [doc/](https://github.com/timrdf/plunk/tree/master/doc)
    * Figures

Dependencies:

* csv2rdf4lod
* j4r (internal)
* rapper
* serdi
