#!/bin/bash
# run as: ./find_dependencies.sh >makefile.d

function print_dependencies()
{
    local include_list
    include_list=$(grep '#include' "$1" | sed -n 's/.*#include\ \"\(.*\)\".*/\1/p')
    if [[ ! -z "$include_list" ]]; then
        local f
        for f in $include_list; do
            if [[ -e "$2$f" ]]; then
                echo -n "$2$f "
                print_dependencies $2$f $2
            fi
        done
    fi
}

echo "#" generated with: $0 $@
echo
for f in $(ls SSDT-NUC*.dsl SSDT-STCK*.dsl); do
    deps=$(print_dependencies "$f" "")
    if [[ ! -z "$deps" ]]; then
        build_target=$(basename "$f")
        build_target=${build_target/.dsl/.aml}
        echo '$(BUILDDIR)/'$build_target : $f $deps
        echo
    fi
done
