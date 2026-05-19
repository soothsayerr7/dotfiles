#!/usr/bin/env bash

set -euo pipefail

sudo tee /etc/modules-load.d/openrgb.conf <<EOF
i2c-dev
i2c-piix4
EOF
