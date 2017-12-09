#!/bin/bash

# ==============================================================================
#                     BUTLER WATCH & BUILD MARKDOWN SOURCES                     
# ==============================================================================
# Watch *.markdown files for changes, and invoke Butler to rebuild current folder
# Reuires multiwatch (Node.js):
# https://www.npmjs.com/package/multiwatch

multiwatch *.markdown -e "butler -b"