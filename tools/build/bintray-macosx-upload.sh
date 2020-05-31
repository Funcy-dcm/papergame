#! /bin/bash

set -e
set -x

user_info="$BINTRAY_USER:$BINTRAY_API_KEY"
repo="papergame"
package="MacOSX-x64"
build_dir="."
build_ver="${TRAVIS_TAG}"
file_path="PaperGame-$build_ver.dmg"
build_file="$(ls ${build_dir}/*.dmg | head -n 1)"
upload_url="https://api.bintray.com/content/papergame/$repo/$package/$build_ver/$file_path?override=1&publish=1"

if [ -z "$build_file" ]; then
  echo "ERROR: Cannot upload. No dmg file found in $build_dir"
  exit 1
else
  echo "Uploading $file to $upload_url"
  curl -T "${build_file}" -u"${user_info}" "${upload_url}" || exit 1
fi
