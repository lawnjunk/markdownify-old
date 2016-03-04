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
