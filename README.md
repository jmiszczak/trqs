TRQS is a package for Mathematica computing system, which allows to generate
random quantum states using truly random numbers generated according to the 
rules of quantum mechanics. This README file contains some compilation and 
installation instructions.

(c) 2011-2012 Jaroslaw Miszczak <miszczak(at)iitis.pl>

- Introduction
- Compilation
- Installation
- Quantis backend - detailed information
  -- Compilation
  -- Installation
  -- Known problems
-  QRNG backend - detailed information
-- Compilation
-- Installation
- Publications
- Examples
- Contact

# Introduction

TRQS is a Mathematica package, which allows to utilise quantum true random
number generators. Currently, the package supports two sources of randomness:
Quantis RNG produced by ID Quantique S.A. and QRNG on-line service based on the
generator developed by Nano-Optics group at the Department of Physics of
Humboldt University and PicoQuant GmbH.

# Compilation

The MathLink source files and build scripts require some editing prior to the
compilation. The Makefile in the main directory contains variables required to
locate libQRNG and/or libQuantis headers and libraries. Edit variables required
for the backend you are currently using. Note, that you should note edit the
Makefiles in the backends' directories

In order to compile *.tm source files one should note that:
  - a working Mathematica installation is required,
  - one of the supported backends must be installed.

Detailed instructions for compiling and running the supported backends are given 
below.

Please note, that gcc and g++ compilers are used during the compilation process.
You can chaned this by redefining CC and CXX variable in the main Makefile or
calling make as

  make CC=icc

in order to use a diffrent C compiler

# Installation

After compiling the source files, a file name
TRQS-$(TRQS_VERSION)-$(BACKEND_NAME).tgz will be created. It contains MatheLink
executables, TRQS.m package files, this README file, some information about the
backend in PDF format and a Mathematica notebook with some example.

In order to use the package you need to copy TRQS.m file and
TRQS_$(BACKEND_NAME) to some directory where Mathematica can find them.

Note the in the case of Quantis backend there are two variants of the package,
one of which has -NoHw prefix denotain that it is based on the fake Quantis
device provided by libQuantis-NoHw library. This backen does not provide a true
random numbers and it is provided for the testing purpose only.

## Quantis backend - details

### Compilation

For the purpose of compiling Mathlink sources it is assumed that the header
files are installed in /usr/local/IDQ/Quantis/include and libraries in
/usr/local/IDQ/Quantis/lib. Modify QUANTIS_HOME in the Makefile if this is not
the case.

Consult quantis_installation.pdf document in TRQS_Quantis directory if you have
problems with the installation of the device.

It is also possible to run the TRQS package using this backend without a Quantis
device. In order to do this compile the sources using quantis-nohw-bin-dist
target.

### Installation

In order to run TRQS using Quantis backend you must make sure that the dynamic
loader knows where to search for libQuantis (e.g. add /usr/local/IDQ/Quantis/lib
to /etc/ld.so.conf).

The package is installed by copying TRQS.m files and TRQS_Quantis/ directory to 
$HOME/.Mathematica/Applications directory.

### Known problems

#### LibQuantis 2.9 and Ubuntu 12.04

LibQuantis in version 2.9 or earlier does not work on Ubuntu 12.04 or any Linux 
distribution with libusb-1.0.9 or higher. See quantis_libusb_problem.txt file 
in TRQS_Quantis directory for the possible solution.

## QRNG backend - details

### Compilation

For the purpose of compiling Mathlink sources it is assumed that the header 
files are installed in /usr/local/PicoQuant/QRNG/include and libraries in 
/usr/local/PicoQuant/QRNG/lib. Modify QRNG_HOME in the Makefile if this is 
not the case.

### Installation

In order to run TRQS using QRNG backend it is necessary to register on the
http://qrng.physik.hu-berlin.de/ web page. User name and password given during
the registration are required to obtain random data from the server.
Registration is also required to download files from the web site.

As QRNG backend is based on the on-line server, it is necessary, in order to use
it, to have a working Internet connection. The on-line service runs on port
4499, so be sure that your firewall allows to use this port for the outgoing
connections.

The package is installed by copying TRQS.m files and TRQS_QRNG/ directory to
$HOME/.Mathematica/Applications director.

## Examples

Mathematica notebooks TRQSTest_QRNG.nb and TRQSTest_Quantis.nb contains some 
examples. Note that they include some functions specific for the backends.

## Publications

The package has been described in

  - J.A. Miszczak, *Generating and using truly random quantum states in Mathematica*, Comput. Phys. Commun., Vol. 183, No. 1 (2012), pp. 118-124. arXiv:<a href="http://arxiv.org/abs/1102.4598">1102.4598</a> DOI:<a href="http://doi.org/10.1016/j.cpc.2011.08.002">10.1016/j.cpc.2011.08.002</a> <a href="https://miszczak.eu/files/papers/miszczak12generating.pdf">[PDF]</a>

  - J.A. Miszczak, *Employing online quantum random number generators for generating truly random quantum states in Mathematica*, Comput. Phys. Commun., Vol. 184, No. 1 (2013), pp. 257–258. arXiv:<a href="http://arxiv.org/abs/1208.3970">1208.3970</a> DOI:<a href="http://doi.org/10.1016/j.cpc.2012.08.012">10.1016/j.cpc.2012.08.012</a> <a href="https://miszczak.eu/files/papers/miszczak13employing.pdf">[PDF]</a>


## Contact

If you have any problems using TRQS package, please do not hesitate to write an
email to miszczak (at) iitis.pl with TRQS in the subject line.
