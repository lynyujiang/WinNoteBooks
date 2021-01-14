#!/usr/bin/env bash

# => To Clean out ALL vim Swap Files
find . -type f -name "*.sw[klmnop]" -delete

# => To Clean out ALL vim undo Files
find . -type f -name ".*.un~" -delete

# => To Clean out ALL vim backup Files
find . -type f -name "*~" -delete


