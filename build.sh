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

$0 -X tag NEWTAG [ PREVTAG ]
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
    tag)
        if [[ -z ${2:-""} ]]
        then
            echo -e "$1\n $(git changelog --stdout --tag $1 --all)"          | git tag -F- $1
        else
            echo -e "$1\n $(git changelog --stdout --tag $1 --start-tag $2)" | git tag -F- $1
            exit 1
        fi
        ;;
    *) usage ; exit 1 ;;
esac

################################################################################

