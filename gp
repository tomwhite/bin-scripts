#!/bin/bash
#
# Create a patch file from git diff

JIRA=$1
if [ "$#" -gt 1 ]; then
  HASH=$2
fi
git diff --no-prefix $HASH >  ~/patches/$JIRA.patch

