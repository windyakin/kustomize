#!/bin/bash -e

mkdir -p /kustomize

cat "$(dirname $0)/download_urls.txt" | while read -r line; do
  version=$(echo "$line" | awk -F " " '{ print $1 }')
  url=$(echo "$line" | awk -F " " '{ print $2 }')
  echo "Download ${version}"
  mkdir -p "/kustomize/${version}"
  curl -SL "${url}" -o "/kustomize/${version}/${version}.tar.gz"
  tar xzf "/kustomize/${version}/${version}.tar.gz" -C "/kustomize/${version}/"
  rm "/kustomize/${version}/${version}.tar.gz"
done

latest=$(tail -n1 "$(dirname $0)/download_urls.txt")
latest_version=$(echo "$latest" | awk -F " " '{ print $1 }')
ln -s "/kustomize/${latest_version}/kustomize" "/usr/bin/kustomize"
