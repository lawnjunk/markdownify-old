#!/bin/bash 
include(){
  echo "importing $1"
  cat $1 >> markdownify
  echo >> markdownify
}

setup(){
  echo "building new markdownify"
  rm markdownify
  echo "#!/bin/bash" > markdownify
  chmod 755 markdownify
}

setup
include "./lib/normalize-path.sh"
include "./lib/user-input.sh"
include "./lib/get-relitive-path.sh"
include "./lib/get-file-extension.sh"
include "./lib/ignore-dir.sh"
include "./lib/ignore-file.sh"
include "./lib/ignore-input.sh"
include "./lib/walkfiles.sh"
include "./lib/file-to-markdown.sh"
include "./lib/render-markdown-for-file.sh"
include "./lib/generate-markdown.sh"
include "./main.sh"
echo "done"
