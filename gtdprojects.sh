#! /bin/bash

# MIT License
#
# Copyright (c) [year] [fullname]
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Print first parameter to standard error output.
printerr() {
    echo "$1" >&2;
}

# Print first parameter on standard output if verbose mode is enabled.
printverbose() {
    if [ "$verbose" = "1" ]; then
        echo "$1";
    fi
}

# If parameter is a valid command name print this command's usage.
# If parameter is a non-empty string but is not a valid command,
# print "invalid command" error message.
# Otherwise print global usage message.
printusage() {
    case "$1" in
        create)
            cat << EOF
usage: create PROJECT_NAME

Creates the project name PROJECT_NAME.
It creates the directory "PREFIX"_"PROJECT_NAME" in the projets root folder.
EOF
            ;;
        "")
            cat << EOF
usage: gtdprojects.sh [<options>] [command [command-arguments]]

Options:
            -v          verbose
            -h          print this message

Commands:
            create
            help

Run ̀\`gtdprojects.sh help <command>\` for command specific help.
EOF
            ;;
        *)
            printerr "Unknown command: \"$1\".";
            exit 1;;
    esac
}

cmd_create() {
    printverbose "Command is create.";
    suffix="$(date +%Y-%m)_"
    printverbose "Suffix for created folder is $suffix."
    if ! [[ $1 =~ ^[a-zA-Z0-9_-]+$ ]]; then
        printerr "Wrong project name \"$1\", allowed characters:"\
" alphanumeric characteurs (0-9, a-z, A-Z), \"-\", \"_\".";
        exit 1;
    fi
    newpath="$path/${suffix}${1}"
    printverbose "Path for new project will be: \"$newpath\".";
    if [ -e "$newpath" ]; then
        printerr "Path for new project already exists: \"$newpath\"!";
        exit 1;
    fi
    printverbose "Creating new directory.";
    mkdir "$newpath";
    if [[ $? != 0 ]]; then
        printerr "Error when trying to create directory \"$newpath\".";
        exit 1;
    fi
    printverbose "Successfully created new directory $newpath.";
}


path=/path/to/folder
if [ ! -z ${GTD_PROJECTS_PATH} ]; then
    path="$GTD_PROJECTS_PATH"
fi

# Check the path is correct
if [ ! -d "$path" ]; then
    printerr "Invalid path for root projects folder: \"$path\"";
fi

TEMP=$(getopt -o vh -n 'gtdprojects.sh' -- "$@")
eval set -- "$TEMP"

if [ $? != 0 ] ; then printerr "Terminating..."; exit 1 ; fi

while true; do
    case "$1" in
        -v)
            verbose=1; shift ;;
        -h)
            printusage; exit 0;;
        --) shift; break;;
        *)
            printerr "Internal error during arguments parsing!";
            exit 1 ;;
    esac
done

while true; do
    case "$1" in
        help)
            printusage "$2";
            exit 0;;
        create)
            cmd_create "$2";
            exit 0;;
        "")
            printusage;
            exit 0;;
    esac
done
exit 0;
