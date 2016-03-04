**/gulpfile.js**  
##/lib  
``` bash  
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
``` bash  
getFileExtension(){
  file="$1"
  fileBaseName=$(basename $file)
  fileExtension=$(echo $fileBaseName |cut -d '.' -f 2)
  echo "$fileExtension" 
}
```  
``` bash  
getRelitivePath(){
  absolutePath="$1"
  pwdLength="${#PWD}"
  echo "${absolutePath:$pwdLength}"
}
```  
``` bash  
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
``` bash  
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
``` bash  
for file in $(walkfiles $PWD); do
  fileExtnesion=$(getFileExtension $file)
  relitiveFilePath=$(getRelitivePath $file)
  if [ -d $file ];then 
    dirNameMarkdown "$relitiveFilePath"
  else 
    case $fileExtnesion in
      *"md"*)
        markdownMarkdown "$relitiveFilePath";;
      *"sh"*)
        codeBlockMarkdown "$relitiveFilePath" "bash";;
      *)
        fileNameMarkdown "$relitiveFilePath"

    esac
  fi
done
```  
``` bash  
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
``` bash  
walkfiles $PWD
```  
**/makefile**  
**/markdownify**  
**/package.json**  
``` bash  
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
