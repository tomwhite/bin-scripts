#!/bin/bash
#
# Clean svn by reverting any local changes and bring changes from repo

svn revert -R .
svn up
