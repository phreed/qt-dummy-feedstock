About qt
========

Home: http://qt-project.org

Package license: LGPL-3.0-only

Feedstock license: [BSD-3-Clause](https://github.com/phreed/qt-feedstock/blob/v5.2.1/LICENSE.txt)

Summary: Qt is a cross-platform application and UI framework.

Development: https://github.com/qtproject

Documentation: https://www.qt.io/blog/2014/02/05/qt-5-2-1-released

Qt helps you create connected devices, UIs & applications that run
anywhere on any device, on any operating system at any time.


Current build status
====================


<table>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-qt-green.svg)](https://anaconda.org/mesomorph/qt) | [![Conda Downloads](https://img.shields.io/conda/dn/mesomorph/qt.svg)](https://anaconda.org/mesomorph/qt) | [![Conda Version](https://img.shields.io/conda/vn/mesomorph/qt.svg)](https://anaconda.org/mesomorph/qt) | [![Conda Platforms](https://img.shields.io/conda/pn/mesomorph/qt.svg)](https://anaconda.org/mesomorph/qt) |

Installing qt
=============

Installing `qt` from the `mesomorph` channel can be achieved by adding `mesomorph` to your channels with:

```
conda config --add channels mesomorph
conda config --set channel_priority strict
```

Once the `mesomorph` channel has been enabled, `qt` can be installed with `conda`:

```
conda install qt
```

or with `mamba`:

```
mamba install qt
```

It is possible to list all of the versions of `qt` available on your platform with `conda`:

```
conda search qt --channel mesomorph
```

or with `mamba`:

```
mamba search qt --channel mesomorph
```

Alternatively, `mamba repoquery` may provide more information:

```
# Search all versions available on your platform:
mamba repoquery search qt --channel mesomorph

# List packages depending on `qt`:
mamba repoquery whoneeds qt --channel mesomorph

# List dependencies of `qt`:
mamba repoquery depends qt --channel mesomorph
```




Updating qt-feedstock
=====================

If you would like to improve the qt recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`mesomorph` channel, whereupon the built conda packages will be available for
everybody to install and use from the `mesomorph` channel.
Note that all branches in the phreed/qt-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string)
   back to 0.

Feedstock Maintainers
=====================

* [@phreed](https://github.com/phreed/)

