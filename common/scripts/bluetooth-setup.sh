#!/usr/bin/env bash

set -euo pipefail

paru -S bluez bluez-utils

sudo systemctl enable --now bluetooth
