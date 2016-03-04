ignoreDir(){
  file="$1"
  fileMatchesIgnoreCase="no"

  for ignore in $(cat .ignore);do
    if [ ! $(basename "$file") = "$ignore" ];then  
      fileMatchesIgnoreCase='yes'
      continue
    fi
  done

  [ $fileMatchesIgnoreCase = "no" ] && walkfiles $file 
}

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
