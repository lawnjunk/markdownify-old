**/build.sh**  
``` sh  
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
  echo "![]($file)  "
}

markdownMarkdown(){
  file=$1 
  cat ".$file" 
  echo "  "
}
```  
**/lib/generate-markdown.sh**  
``` sh  
generateMarkdown(){
  for file in $(walkfiles $PWD); do
    fileExtnesion=$(getFileExtension $file)
    relitiveFilePath=$(getRelitivePath $file)
    if [ -d $file ];then 
      dirNameMarkdown "$relitiveFilePath"
    else 
      renderMarkdownForFile "$relitiveFilePath" "$fileExtnesion"
    fi
  done
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
    if [ $(basename "$file") = "$ignore" ] || [  $file = $outputFilePath ] ;then  
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
    if [ $(basename "$file") = "$ignore" ] || [ $file = $outputFilePath ] ;then  
    #if [ $(basename "$file") = "$ignore" ];then  
      fileMatchesIgnoreCase="yes"
      continue
    fi
  done

  [ $fileMatchesIgnoreCase = "no" ] && echo $file 
}
```  
**/lib/ignore-input.sh**  
``` sh  
ignoreInput(){
  file="$1"
  echo "batman file           $file"
  echo "outputFilePath $outputFilePath"
  fileMatchesIgnoreCase="no"
  if [ "$file" = "$outputFilePath" ];then
    fileMatchesIgnoreCase="yes" 
  fi
  echo $fileMatchesIgnoreCase
}
```  
**/lib/normalize-path.sh**  
``` sh  
function normpath(){
  # remove all /./ sequences.
  local path=${1//\/.\//\/}

  # Remove dir/.. sequences.
  while [[ $path =~ ([^/][^/]*/\.\./) ]]; do
    path=${path/${BASH_REMATCH[0]}/}
  done
  echo $path
}
```  
**/lib/render-markdown-for-file.sh**  
``` sh  
renderMarkdownForFile(){
  relitiveFilePath="$1"
  fileExtnesion="$2"
  case $fileExtnesion in
    *"md"*)
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
    *"css"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"jsx"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"scss"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"sass"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"png"*)
      imageMarkdown "$relitiveFilePath";;
    *"jpg"*)
      imageMarkdown "$relitiveFilePath";;
    *"gif"*)
      imageMarkdown "$relitiveFilePath";;
    *"tif"*)
      imageMarkdown "$relitiveFilePath";;
    *"bmp"*)
      imageMarkdown "$relitiveFilePath";;
    *)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "txt";;
    esac
}
```  
**/lib/user-input.sh**  
``` sh  
if [ $# -eq 0 ];then
  echo "USAGE ERROR: try markdownify <OUTPUT FILE NAME>"
  exit 1
fi

outputFilePath="$PWD/$1"
outputFilePath=$(normpath $outputFilePath)
```  
**/lib/walkfiles.sh**  
``` sh  
# recursivly print all paths of files not in .ignore
walkfiles(){
  for file in $(ls -Rd $1/*);do
    if [ -d "$file" ]; then
      #if [ -f "$PWD/.ignore" ]; then 
        ignoreDir $file
      #else
        #walkfiles $file
      #fi
    else 
      #if [ -f "$PWD/.ignore" ]; then 
        ignoreFile $file
      #else
        #[ $(ignoreInput) = "no" ] && echo $file
      #fi
    fi
  done
}
```  
![](/lulwat.png)  
**/main.sh**  
``` sh  
echo "Writing Markdown to $outputFilePath"
generateMarkdown > $outputFilePath
```  
**/markdownify**  
``` txt  
#!/bin/bash
function normpath(){
  # remove all /./ sequences.
  local path=${1//\/.\//\/}

  # Remove dir/.. sequences.
  while [[ $path =~ ([^/][^/]*/\.\./) ]]; do
    path=${path/${BASH_REMATCH[0]}/}
  done
  echo $path
}

if [ $# -eq 0 ];then
  echo "USAGE ERROR: try markdownify <OUTPUT FILE NAME>"
  exit 1
fi

outputFilePath="$PWD/$1"
outputFilePath=$(normpath $outputFilePath)

getRelitivePath(){
  absolutePath="$1"
  pwdLength="${#PWD}"
  echo "${absolutePath:$pwdLength}"
}

getFileExtension(){
  file="$1"
  fileBaseName=$(basename $file)
  fileExtension=$(echo $fileBaseName |cut -d '.' -f 2)
  echo "$fileExtension" 
}

ignoreDir(){
  file="$1"
  fileMatchesIgnoreCase="no"

  for ignore in $(cat .ignore);do
    if [ $(basename "$file") = "$ignore" ] || [  $file = $outputFilePath ] ;then  
      fileMatchesIgnoreCase='yes'
      continue
    fi
  done

  if [ $fileMatchesIgnoreCase = "no" ];then
    echo $file
    walkfiles $file
  fi
}

ignoreFile(){
  file="$1"
  fileMatchesIgnoreCase="no"

  for ignore in $(cat "$PWD/.ignore");do
    if [ $(basename "$file") = "$ignore" ] || [ $file = $outputFilePath ] ;then  
    #if [ $(basename "$file") = "$ignore" ];then  
      fileMatchesIgnoreCase="yes"
      continue
    fi
  done

  [ $fileMatchesIgnoreCase = "no" ] && echo $file 
}

ignoreInput(){
  file="$1"
  echo "batman file           $file"
  echo "outputFilePath $outputFilePath"
  fileMatchesIgnoreCase="no"
  if [ "$file" = "$outputFilePath" ];then
    fileMatchesIgnoreCase="yes" 
  fi
  echo $fileMatchesIgnoreCase
}

# recursivly print all paths of files not in .ignore
walkfiles(){
  for file in $(ls -Rd $1/*);do
    if [ -d "$file" ]; then
      #if [ -f "$PWD/.ignore" ]; then 
        ignoreDir $file
      #else
        #walkfiles $file
      #fi
    else 
      #if [ -f "$PWD/.ignore" ]; then 
        ignoreFile $file
      #else
        #[ $(ignoreInput) = "no" ] && echo $file
      #fi
    fi
  done
}

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
  echo "![]($file)  "
}

markdownMarkdown(){
  file=$1 
  cat ".$file" 
  echo "  "
}

renderMarkdownForFile(){
  relitiveFilePath="$1"
  fileExtnesion="$2"
  case $fileExtnesion in
    *"md"*)
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
    *"css"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"jsx"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"scss"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"sass"*)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "$fileExtnesion";;
    *"png"*)
      imageMarkdown "$relitiveFilePath";;
    *"jpg"*)
      imageMarkdown "$relitiveFilePath";;
    *"gif"*)
      imageMarkdown "$relitiveFilePath";;
    *"tif"*)
      imageMarkdown "$relitiveFilePath";;
    *"bmp"*)
      imageMarkdown "$relitiveFilePath";;
    *)
      fileNameMarkdown "$relitiveFilePath"
      codeBlockMarkdown "$relitiveFilePath" "txt";;
    esac
}

generateMarkdown(){
  for file in $(walkfiles $PWD); do
    fileExtnesion=$(getFileExtension $file)
    relitiveFilePath=$(getRelitivePath $file)
    if [ -d $file ];then 
      dirNameMarkdown "$relitiveFilePath"
    else 
      renderMarkdownForFile "$relitiveFilePath" "$fileExtnesion"
    fi
  done
}

echo "Writing Markdown to $outputFilePath"
generateMarkdown > $outputFilePath

```  
