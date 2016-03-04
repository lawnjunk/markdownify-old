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
