#!/usr/bin/env bash

LINT=
GENERATE=

while getopts :lL:gG: opt
do
    case "${opt}" in
        l)
            LINT=1
            ;;
        g)
            GENERATE=1
            ;;
        \?)
            echo "ERROR: unknown parameter \"$OPTARG\""
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

IFS=$'\n'
# create an array of all unique directories containing .tf files 
arr=($(find . -name '*.tf' | xargs -I % sh -c 'dirname %' | sort -u))
unset IFS

for i in "${arr[@]}"
do
    docs_dir=$i/_docs

    source_doc=$docs_dir/MAIN.md
    target_doc=$i/README.md


    # check for _docs folder
    if [[ -d "$docs_dir" ]]; then

        if ! test -f $source_doc; then 
            echo "ERROR: $source_doc is missing"; exit 1
        else

            # generate the tf documentation
            if [[ -n "$GENERATE" ]]; then
                echo "Generating docs for: $i"
                cat $source_doc <(echo) <(scripts/terraform-docs.sh markdown $i) > $target_doc
            fi

            # lint the tf documentation
            if [[ -n "$LINT" ]]; then
                echo "Linting docs for: $i"
                diff $target_doc <(cat $source_doc <(echo) <(scripts/terraform-docs.sh markdown $i))
            fi

        fi

    fi
done