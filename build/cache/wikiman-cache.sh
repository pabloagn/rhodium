#!/usr/bin/env bash

# Download latest Makefile
curl -L 'https://raw.githubusercontent.com/filiparag/wikiman/master/Makefile' -o 'wikiman-makefile'

# Example for Linux: install ArchWiki and TLDR pages
make -f ./wikiman-makefile source-arch source-tldr
sudo make -f ./wikiman-makefile source-install
sudo make -f ./wikiman-makefile clean

# Verify active sources
wikiman -S
