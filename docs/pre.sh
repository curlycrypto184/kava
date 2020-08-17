#!/usr/bin/env bash

# Clone each module's markdown files
mkdir -p Modules

for D in ../x/*; do
  if [ -d "${D}" ]; then
    rm -rf "Modules/$(echo $D | awk -F/ '{print $NF}')"
    mkdir -p "Modules/$(echo $D | awk -F/ '{print $NF}')" && cp -r $D/spec/* "$_"
  fi
done

# Platform docs (Web application, Ledger, etc.)
platformDir="platform"
mkdir -p "./${platformDir}"
cp ./ledger.md "./${platformDir}/ledger.md"

# Client docs (JavaScript SDK)
baseGitUrl="https://raw.githubusercontent.com/Kava-Labs"
clientGitRepo="javascript-sdk"
clientDir="building"

mkdir -p "./${clientDir}"
curl "${baseGitUrl}/${clientGitRepo}/master/README.md" -o "./${clientDir}/${clientGitRepo}.md"
echo "---
parent:
  order: false
---" > "./${clientDir}/readme.md"

# Copy the kava-3-migration guide
cp ../contrib/kava-3/migration.md "./${clientDir}/kava-3-migration-guide.md"

# Kava Tools docs
toolsGitRepo="kava-tools"
toolsDir="tools"
toolDocs=("auction" "oracle")

mkdir -p "./${toolsDir}"
for T in ${toolDocs[@]}; do
  curl "${baseGitUrl}/${toolsGitRepo}/master/${T}/README.md" -o "./${toolsDir}/${T}.md"
done
echo "---
parent:
  order: false
---" > "./${toolsDir}/readme.md"
