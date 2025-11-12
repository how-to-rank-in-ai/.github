#!/usr/bin/env bash
# Usage: ./replace_placeholders.sh YOUR-ORG NEW_GOOGLE_CODE
set -euo pipefail
ORG="${1:-YOUR-ORG}"
CODE="${2:-google25ab32e9faa1d89e}"

echo "Updating sitemap.xml with org=${ORG} ..."
sed -i "s|https://github.com/YOUR-ORG/|https://github.com/${ORG}/|g" sitemap.xml
sed -i "s|https://github.com/YOUR-ORG/.github/blob/main/profile/README.md|https://github.com/${ORG}/.github/blob/main/profile/README.md|g" sitemap.xml

pushd profile >/dev/null
  sed -i "s|https://github.com/YOUR-ORG/|https://github.com/${ORG}/|g" sitemap.xml
  sed -i "s|https://github.com/YOUR-ORG/.github/blob/main/profile/README.md|https://github.com/${ORG}/.github/blob/main/profile/README.md|g" sitemap.xml
popd >/dev/null

if [[ "${CODE}" != "google25ab32e9faa1d89e" ]]; then
  echo "Renaming verification files to ${CODE}.html ..."
  mv "${CODE}.html" 2>/dev/null || true
  mv "google25ab32e9faa1d89e.html" "${CODE}.html"
  pushd profile >/dev/null
    mv "google25ab32e9faa1d89e.html" "${CODE}.html"
  popd >/dev/null
  sed -i "s/google25ab32e9faa1d89e/${CODE}/g" "${CODE}.html"
  sed -i "s/google25ab32e9faa1d89e/${CODE}/g" "profile/${CODE}.html"
fi

echo "Done."
