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
