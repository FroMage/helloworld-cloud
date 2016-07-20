#!/bin/sh

CEYLON=ceylon

if test -n "$CEYLON_HOME"
then
 CEYLON=$CEYLON_HOME/bin/ceylon
 if test \! -x $CEYLON
 then
   echo "Could not find ceylon at CEYLON_HOME: $CEYLON_HOME"
   exit 1
 fi
else
 if ! which ceylon > /dev/null
 then
   echo "Could not find ceylon executable in PATH, add it to PATH or set CEYLON_HOME to point at distribution"
   exit 1
 fi
fi

if $CEYLON --version | grep 1.2.3 > /dev/null
then
 $CEYLON compile-js
 $CEYLON copy --js --with-dependencies --out lib/node_modules/ fh.demo.hello/1.0.0
else
 echo "Your distribution of Ceylon is too old, download a nightly from https://ci-ceylon.rhcloud.com/job/ceylon-distribution/lastSuccessfulBuild/"
 exit 1
fi
