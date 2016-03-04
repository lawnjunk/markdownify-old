getRelitivePath(){
  absolutePath="$1"
  pwdLength="${#PWD}"
  echo "${absolutePath:$pwdLength}"
}
