#!/bin/bash
#
# Run patch using a filename or a URL.
#

# From http://curtisb.posterous.com/a-handy-bash-function-for-crea
# Given a path to a file (relative or absolute), print a "file://" URL for
# that file.
fileurl()
{
  # Split the directory name out of the argument path.
  #   "/dir/subdir/file" ==> "/dir/subdir"
  #   "dir/subdir/file" ==> "dir/subdir"
  #   "subdir/file" ==> "subdir"
  #   "file" ==> "."
  TEMP="/$1"                            # Hack: Prepend a slash so there's at least one
  TEMP="${TEMP%/*}"                     # Chop off the trailing "/file"
  TEMP="${TEMP#/}"                      # Remove the leading slash if it's stil there
  DIRNAME="${TEMP:-.}"                  # If DIRNAME is empty, set it to "."

    # Get the base file name from the argument path.
  BASENAME="${1##*/}"                   # Remove everything up to the last slash, inclusive

    # Convert the directory name to an absolute path.
  ABSDIRNAME=$(cd "$DIRNAME"; pwd)

    # Echo the file URL built from the components.
  echo "file://$ABSDIRNAME/$BASENAME"
}

uri=$1
if [ -z "$2" ]; then
  pl=0
else
  pl=$2
fi
if [ -f $1 ]; then
  uri=`fileurl $1`
elif [ -f ~/patches/$1.patch ]; then
  uri=`fileurl ~/patches/$1.patch`
elif [ -f ~/Downloads/$1.patch ]; then
  uri=`fileurl ~/Downloads/$1.patch`
fi
curl $uri | patch -p $pl -E
