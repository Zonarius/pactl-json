#!/bin/sh

# Requires [dstep](https://github.com/jacob-carlborg/dstep)

TMPDIR=`mktemp -d`
FILES=`find /usr/include/pulse -type f ! -name 'glib*'`

cp -r $FILES $TMPDIR

# --output does not work https://github.com/jacob-carlborg/dstep/issues/136
# dstep --output ./source/bindings/pulse $TMPDIR/*
dstep --translate-macros=false --package pulseaudio.bindings.pulse $TMPDIR/*

mv $TMPDIR/*.d source/pulseaudio/bindings/pulse
rm -rf $TMPDIR