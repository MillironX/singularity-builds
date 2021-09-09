<p align="center">
  <img src="singularity-builds-artwork.svg" alt="Logo" width="400">
</p>

# Singularity Builds

[![Sylabs Cloud Library](https://img.shields.io/static/v1?label=Sylabs%20Cloud%20Library&message=millironx/default&color=yellowgreen&logo=linuxcontainers&style=flat-square)](https://cloud.sylabs.io/library/millironx/default)
[![MIT License](https://img.shields.io/github/license/MillironX/singularity-builds?style=flat-square)](https://github.com/MillironX/singularity-builds/blob/master/LICENSE.md)

Definition files for building [Nextflow]-compatible [Singularity] container
images to use in bioinformatics pipelines. Programs get containers in this
repository if I can't find an up-to-date container that also has Nextflow's
dependencies installed (usually `bash` and `ps` are the culprits). All of these
images are available on the [Sylabs Cloud Library] for easy access.

## Get started

1. [Install Singularity]
2. Enter the container, e.g.

    ```bash
    singularity shell library://millironx/default/julia:latest
    ```

3. Execute commands, e.g.

    ```shellsession
    Singularity> julia
                   _
       _       _ _(_)_     |  Documentation: https://docs.julialang.org
      (_)     | (_) (_)    |
       _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
      | | | | | | |/ _` |  |
      | | |_| | | | (_| |  |  Version 1.6.1 (2021-04-23)
     _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
    |__/                   |

    julia>
    ```

## Where else to find container images

### State Public Health Bioinformatics (StaPH-B) Dockerfiles

[:globe_with_meridians: Website](https://staph-b.github.io/) -
[:octocat: GitHub](https://github.com/StaPH-B/docker-builds) -
[:whale: Docker hub](https://hub.docker.com/u/staphb)

All of these images are tested for Nextflow and Singularity compatability, and
are updated on a regular basis. I've even contributed to their repository.

### Niema Moshiri's Dockerfiles

[:octocat: GitHub](https://github.com/Niema-Docker) -
[:whale: Docker hub](https://hub.docker.com/u/niemasd)

Slim bioinformatics images based on Alpine Linux with useful (but optional)
common combinations.

### Biocontainers Registry

[:globe_with_meridians: Website](https://biocontainers.pro/) -
[:octocat: GitHub](https://github.com/BioContainers/containers) -
[:whale: Docker hub](https://hub.docker.com/u/biocontainers)

Most of these images are already in Singularity format, and there are _a lot_ of
tools for the picking here.

### McDonnell Genome Institute

[:octocat: GitHub](https://github.com/orgs/genome/repositories?language=dockerfile) -
[:whale: Docker hub](https://hub.docker.com/u/mgibio)

These folks make high-quality and well-maintained images for their own and
other tools.

## Artwork

Artwork was designed by [@MillironX] by remixing:

- [DNA] by Scout (Public domain)
- [Cardboard box] by Rushtini (Public domain)
- [Pointing Boy in Baseball Cap] by ruthirsty (Public domain)
- [Singularity Logo] by Sylabs (BSD 3-Clause)

[Nextflow]: https://nextflow.io
[Singularity]: https://sylabs.io/singularity
[Sylabs Cloud Library]: https://cloud.sylabs.io/library/millironx/default
[Install Singularity]: https://sylabs.io/guides/3.8/admin-guide/installation.html
[@MillironX]: https://github.com/MillironX
[DNA]: https://openclipart.org/detail/192915/dna
[Cardboard box]: https://openclipart.org/detail/192915/dna
[Pointing Boy in Baseball Cap]: https://openclipart.org/detail/281363/pointing-boy-in-baseball-cap
[Singularity Logo]: https://github.com/sylabs/singularity/blob/master/docs/logos/singularity_v3.svg
