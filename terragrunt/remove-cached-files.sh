#!/bin/sh
#!/bin/bash
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;