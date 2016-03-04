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
