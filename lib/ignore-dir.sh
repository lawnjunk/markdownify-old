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
