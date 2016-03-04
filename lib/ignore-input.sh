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
