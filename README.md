About qt-dummy
==============

Home: https://www.qt.io/

Package license: LGPL-3.0-only

Feedstock license: [BSD-3-Clause](https://github.com/phreed/qt-dummy-feedstock/blob/v5.2.1/LICENSE.txt)

Summary: Qt is a cross-platform application and UI framework.

Development: https://github.com/qtproject

Documentation: https://www.qt.io/blog/2014/02/05/qt-5-2-1-released

Qt helps you create connected devices, UIs & applications that run
anywhere on any device, on any operating system at any time.
This module provides a dummy installer for Qt.
It does not install any Qt package.
It configures the specified Conda environment to use the installed Qt.
It expects the appropriate Qt to have been previously acquired.


Current build status
====================


<table>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-qt--dummy-green.svg)](https://anaconda.org/mesomorph/qt-dummy) | [![Conda Downloads](https://img.shields.io/conda/dn/mesomorph/qt-dummy.svg)](https://anaconda.org/mesomorph/qt-dummy) | [![Conda Version](https://img.shields.io/conda/vn/mesomorph/qt-dummy.svg)](https://anaconda.org/mesomorph/qt-dummy) | [![Conda Platforms](https://img.shields.io/conda/pn/mesomorph/qt-dummy.svg)](https://anaconda.org/mesomorph/qt-dummy) |

Installing qt-dummy
===================

```
mamba install -c mesomorph qt-dummy -n cts --force-reinstall
```

Installing `qt-dummy` from the `mesomorph` channel can be achieved by adding `mesomorph` to your channels with:

```
conda config --add channels mesomorph
conda config --set channel_priority strict
```

Once the `mesomorph` channel has been enabled, `qt-dummy` can be installed with `conda`:

```
conda install qt-dummy
```

or with `mamba`:

```
mamba install qt-dummy
```

It is possible to list all of the versions of `qt-dummy` available on your platform with `conda`:

```
conda search qt-dummy --channel mesomorph
```

or with `mamba`:

```
mamba search qt-dummy --channel mesomorph
```

Alternatively, `mamba repoquery` may provide more information:

```
# Search all versions available on your platform:
mamba repoquery search qt-dummy --channel mesomorph

# List packages depending on `qt-dummy`:
mamba repoquery whoneeds qt-dummy --channel mesomorph

# List dependencies of `qt-dummy`:
mamba repoquery depends qt-dummy --channel mesomorph
```




Updating qt-dummy-feedstock
===========================

If you would like to improve the qt-dummy recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`mesomorph` channel, whereupon the built conda packages will be available for
everybody to install and use from the `mesomorph` channel.
Note that all branches in the phreed/qt-dummy-feedstock are
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

