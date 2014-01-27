#!/bin/bash
#
# Create a patch file from svn diff

svn diff > ~/patches/$1.patch
