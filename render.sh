#!/bin/bash 
include(){
  cat $1 >> markdownify
  echo >> markdownify
}

setup(){
  rm markdownify
  echo "#!/bin/bash" > markdownify
  chmod 755 markdownify
}

setup
include "./lib/normalize-path.sh"
include "./lib/get-relitive-path.sh"
include "./lib/get-file-extension.sh"
include "./lib/ignore-dir.sh"
include "./lib/ignore-file.sh"
include "./lib/walkfiles.sh"
include "./lib/file-to-markdown.sh"
include "./lib/render-markdown-for-file.sh"
include "./lib/generate-markdown.sh"
include "./main.sh"
