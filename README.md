**/gulpfile.js**  
``` js  
'use strict';

const gulp = require('gulp');
const run = require('gulp-run');

const paths = ['lib/**/*.sh', 'main.sh'];

gulp.task('render', function(){
  console.log('first');
  run('./render.sh').exec()
});

gulp.task('watch', function(){
  gulp.watch(paths, ['build']);
});

gulp.task('build', ['render']);
gulp.task('default', ['build']);
```  
##/lib  
**/lib/file-to-markdown.sh**  
``` sh  
dirNameMarkdown(){ 
  file=$1
  echo "##$file  " 
}

fileNameMarkdown(){
  file=$1
  echo "**$file**  "
}

codeBlockMarkdown(){
  file=$1
  fileExtension=$2
  echo "\`\`\` $fileExtension  "
  cat ".$file"
  echo "\`\`\`  "
}

imageMarkdown(){
  file=$1
  echo "[](.$file)"
}

markdownMarkdown(){
  file=$1 
  cat .$file
}
```  
**/lib/get-file-extension.sh**  
``` sh  
getFileExtension(){
  file="$1"
  fileBaseName=$(basename $file)
  fileExtension=$(echo $fileBaseName |cut -d '.' -f 2)
  echo "$fileExtension" 
}
```  
**/lib/get-relitive-path.sh**  
``` sh  
getRelitivePath(){
  absolutePath="$1"
  pwdLength="${#PWD}"
  echo "${absolutePath:$pwdLength}"
}
```  
**/lib/ignore-dir.sh**  
``` sh  
ignoreDir(){
  file="$1"
  fileMatchesIgnoreCase="no"

  for ignore in $(cat .ignore);do
    if [ $(basename "$file") = "$ignore" ];then  
      fileMatchesIgnoreCase='yes'
      continue
    fi
  done

  if [ $fileMatchesIgnoreCase = "no" ];then
    echo $file
    walkfiles $file
  fi
}
```  
**/lib/ignore-file.sh**  
``` sh  
ignoreFile(){
  file="$1"
  fileMatchesIgnoreCase="no"

  for ignore in $(cat "$PWD/.ignore");do
    if [ $(basename "$file") = "$ignore" ];then  
      fileMatchesIgnoreCase="yes"
      continue
    fi
  done

  [ $fileMatchesIgnoreCase = "no" ] && echo $file 
}
```  
**/lib/render-markdown.sh**  
``` sh  
for file in $(walkfiles $PWD); do
  fileExtnesion=$(getFileExtension $file)
  relitiveFilePath=$(getRelitivePath $file)
  if [ -d $file ];then 
    dirNameMarkdown "$relitiveFilePath"
  else 
    case $fileExtnesion in
      *"md"*)
        fileNameMarkdown "$relitiveFilePath"
        markdownMarkdown "$relitiveFilePath";;
      *"sh"*)
        fileNameMarkdown "$relitiveFilePath"
        codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
      *"js"*)
        fileNameMarkdown "$relitiveFilePath"
        codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
      *"py"*)
        fileNameMarkdown "$relitiveFilePath"
        codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
      *"html"*)
        fileNameMarkdown "$relitiveFilePath"
        codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
      *"png"*)
        fileNameMarkdown "$relitiveFilePath"
        imageMarkdown "$relitiveFilePath";;
      *)
        fileNameMarkdown "$relitiveFilePath"

    esac
  fi
done
```  
**/lib/walkfiles.sh**  
``` sh  
# recursivly print all paths of files not in .ignore
walkfiles(){
  for file in $(ls -Rd $1/*);do
    if [ -d "$file" ]; then
      if [ -f "$PWD/.ignore" ]; then 
        ignoreDir $file
      else
        walkfiles $file
      fi
    else 
      if [ -f "$PWD/.ignore" ]; then 
        ignoreFile $file
      else
        echo $file
      fi
    fi
  done
}
```  
##/lul  
**/lul/fog**  
##/lul/wat  
##/lul/wat/grr  
**/lul/wat/grr/ok**  
**/lul/wat/grr/yess**  
**/lul/wat/hello**  
**/lul/wort**  
**/lulwat.png**  
[](./lulwat.png)
**/main.sh**  
``` sh  
walkfiles $PWD
```  
**/makefile**  
**/markdownify**  
**/package.json**  
``` json  
{
  "name": "markdownify",
  "version": "1.0.0",
  "description": "pisssss off tyler",
  "main": "none",
  "scripts": {
    "test": "make"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/slugbyte/markdownify.git"
  },
  "keywords": [
    "'lulz'"
  ],
  "author": "slugbyte",
  "license": "ISC",
  "bugs": {
    "url": "https://github.com/slugbyte/markdownify/issues"
  },
  "homepage": "https://github.com/slugbyte/markdownify#readme",
  "devDependencies": {
    "gulp": "^3.9.1",
    "gulp-run": "^1.6.12"
  }
}
```  
**/render.sh**  
``` sh  
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
include "./lib/get-relitive-path.sh"
include "./lib/get-file-extension.sh"
include "./lib/ignore-dir.sh"
include "./lib/ignore-file.sh"
include "./lib/walkfiles.sh"
include "./lib/file-to-markdown.sh"
include "./lib/render-markdown.sh"
#include "./main.sh"
```  
**/wat**  
