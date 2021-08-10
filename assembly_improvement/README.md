# Assembly Improvement

[![Container source](https://img.shields.io/static/v1?label=Container%20Source&message=GitHub&color=lightgrey&logo=github&style=flat-square)](https://github.com/MillironX/singularity-builds/tree/master/assembly_improvement)
[![assembly_improvement source](https://img.shields.io/static/v1?label=assembly_improvement%20Source&message=GitHub&color=lightgrey&logo=github&style=flat-square)](https://github.com/sanger-pathogens/assembly_improvement)
[![Version 1.160490](https://img.shields.io/static/v1?label=Latest%20version&message=1.160490&color=yellowgreen&logo=linuxcontainers&style=flat-square)](https://cloud.sylabs.io/library/millironx/default/assembly_improvement)
[![Docs](https://img.shields.io/static/v1?label=Docs&message=README&color=blue&style=flat-square)](https://github.com/sanger-pathogens/assembly_improvement/blob/master/README.md)
[![CentOS base](https://img.shields.io/static/v1?label=Base%20image&message=CentOS&color=9fcf32&logo=centos&style=flat-square)](https://www.centos.org/)

Take in an assembly in FASTA format, reads in FASTQ format, and make the
assembly better by scaffolding and gap filling.

## Tools installed

### SSPACE

- `SSPACE_Basic.pl`

### GapFiller

- `GapFiller`

### Abacas

- `abacas.pl`

### SGA

- `sga`

### improve_assembly

- `improve_assembly`
- `diginorm_with_khmer`
- `fill_gaps_with_gapfiller`
- `order_contigs_with_abacas`
- `read_correction_with_sga`
- `scaffold_with_sspace`
