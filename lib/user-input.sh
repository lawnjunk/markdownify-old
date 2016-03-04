if [ $# -eq 0 ];then
  echo "USAGE ERROR: try markdownify <OUTPUT FILE NAME>"
  exit 1
fi

outputFilePath="$PWD/$1"
outputFilePath=$(normpath $outputFilePath)
