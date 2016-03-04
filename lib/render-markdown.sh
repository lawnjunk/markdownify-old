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
        codeBlockMarkdown "$relitiveFilePath" "bash";;
      *)
        fileNameMarkdown "$relitiveFilePath"

    esac
  fi
done
