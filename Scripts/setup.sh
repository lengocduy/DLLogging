#!/bin/bash
set -e

# Enable hook pre-commit
GIT_HOOK_PATH="./.git/hooks"
test -d "$GIT_HOOK_PATH" || mkdir -p "$GIT_HOOK_PATH"
cp ./Scripts/pre-commit.sh ./.git/hooks/pre-commit
chmod +x ./.git/hooks/pre-commit

# Install dependencies frameworks
pod install --verbose

# Support redable markdown in XCode
./Scripts/readable-markdown.sh