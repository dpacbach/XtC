#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0) && pwd)
ROOT=$1
OLD_PWD=$2
NEW_PWD=$3
echo "Reprocessing *.d files (new root: $ROOT)"
echo "========================================"
for f in $(find $ROOT -name "*.d"); do
    echo $f
    perl $SCRIPT_DIR/reloc.pl $OLD_PWD $NEW_PWD $f > $f.tmp || {
        echo "Error relocating $f!"
        exit 1
    }
    #mv $f.tmp $f
done
echo "Done."
echo "========================================"
