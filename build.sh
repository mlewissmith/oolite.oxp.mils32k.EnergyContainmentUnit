#!/bin/bash
set -ue

workdir=$(dirname $0)
builddir=${workdir}/meson.build.d
rm_builddir=false
meson_setup_opts=
xmode="build"

usage() {
    cat<<EOF
Usage:
$0 [ -O BUILDDIR ] [ -RCW ] TARGET...
   -O BUILDDIR : define output builddir ($builddir)
   -R : rm BUILDDIR
   -C : meson setup --reconfigure
   -W : meson setup --wipe

$0 -X tag TAG
EOF
}

while getopts O:RCWX:h opt
do
    case $opt in
        O) builddir=$OPTARG ;;
        R) rm_builddir=true ;;
        C) meson_setup_opts+="--reconfigure " ;;
        W) meson_setup_opts+="--wipe " ;;
        X) xmode=$OPTARG ;;
        h) usage ; exit 0 ;;
        *) usage ; exit 1 ;;
    esac
done
shift $(( ${OPTIND} - 1 ))
cd ${workdir}

################################################################################

case $xmode in
    build)
        ${rm_builddir} && rm -fr ${builddir}
        meson setup --fatal-meson-warnings ${meson_setup_opts} ${builddir}
        meson compile -v -C ${builddir} "$@"
        cp -v -t ${workdir} $(find $builddir -type f -name "*.oxz")
        ;;
    tag) echo -e "$1\n $(git changelog -a -x -t $1)" | git tag -F - $1 ;;
    *) usage ; exit 1 ;;
esac

################################################################################

