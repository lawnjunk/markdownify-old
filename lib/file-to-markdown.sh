dirMarkdown(){ 
  file=$1
  echo "**$file**  " 
}

codeFileMarkdown(){
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
