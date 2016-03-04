#!/bin/bash 
include(){
  cat $1 >> markdownify
}

setup(){
  rm markdownify
  echo "#!/bin/bash" > markdownify
  chmod 755 markdownify
}

setup
include "./lib/test.sh"
include "./lib/walkfiles.sh"
include "./main.sh"

cat markdownify
