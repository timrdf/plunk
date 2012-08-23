`./2source.sh` will show the `wget` commands that it will use to mirror web directories (into `source/`). For example,

```
wget --mirror -e robots=off -A owl,rdf,ttl,nt,n3 --no-parent http://iw.cs.utep.edu/astronomy/
  -|- skipped -|- http://rio.cs.utep.edu/ciserver/person/ - local directory already exists; skipping to avoid duplication.
```

Use the `-w` flag to perform the `wget` commands.

`./2source.sh -w` will add directories and files into `source/`.

Running `2documents.sh` will populate [../documents](https://github.com/timrdf/plunk/tree/master/instances/documents)/automatic/ with Turtle files describing the PML files mirrored in `source/`. For example:

```
source/www.rpi.edu/~michaj6/escience/pml/rule/chip/MakeIntensityFile.owl now described in ../documents/automatic/55eb30ff927bf2c2b9494aa9ef14ac2f.ttl 
source/www.rpi.edu/~michaj6/escience/pml/rule/chip/MakeVelocityFile.owl now described in ../documents/automatic/be7ebc6f11c649c6ee5116467ff82dd2.ttl 
source/www.rpi.edu/~michaj6/escience/pml/rule/chip/RecordRawImage.owl now described in ../documents/automatic/060533fb45e9f0c93e1bd142f290c4e3.ttl 
```
