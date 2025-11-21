#!/usr/bin/sh

FILE="/etc/modules-load.d/i2c.conf"

if [ ! -f "$FILE" ]; then
  sudo sh -c "printf 'i2c-dev\ni2c-piix4\n' > $FILE"
fi
