#!/bin/bash

set -e
set -x

maim -m 1 /tmp/lock.png
convert /tmp/lock.png -scale 5% -scale 2000% /tmp/lock.png
/usr/bin/i3lock -i /tmp/lock.png

