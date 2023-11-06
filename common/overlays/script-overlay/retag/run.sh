# Lê imagens de um diretório, renomeando cada uma.
# -d <path>: Lê os arquivos em <path>.
# -o <path>: Coloca os arquivos renomeados em <path>.
# -c: Mantêm uma cópia do original (i.e. copia ao invés de mover).
# -v: Verbose.

target=$(pwd)
out=$(pwd)
verbose=0
copy=0

function abort () {
  echo "error: $1"
  exit 1
}

for ((i=0; i < $#; i++)); do
  arg="${!i}"
  next_i=$((i+1))
  next="${!next_i}"

  if [[ $arg == "-d" ]]; then
    if [[ $next ]]; then
      if [[ ! -d $next ]]; then
        abort "'-d' must be a directory."
      fi

      target=$next
    else
      abort "'-d' missing directory."
    fi
  fi

  if [[ $arg == "-o" ]]; then
    if [[ $next ]]; then
      if [[ ! -d $next ]]; then
        abort "'-o' must be a directory."
      fi

      out=$next
    else
      abort "'-o' missing directory."
    fi
  fi

  if [[ $arg == "-v" ]]; then
    verbose=1
  fi

  if [[ $arg == "-c" ]]; then
    copy=1
  fi
done

function get_rename () {
  zenity --entry \
    --title="Renaming '$1'" \
    --text="Type in new name" \
    --cancel-label="Stop" 2> /dev/null
}

function may_be_image () {
  ext=${1##*.}
  [ "$ext" ] && { [ "$ext" == "png" ] || [ "$ext" == "jpg" ] || [ "$ext" == "jpeg" ] || [ "$ext" == "gif" ]; }
}

for filepath in "$target"/*; do
  file=$(basename "$filepath")

  if ! may_be_image "$file"; then
    if [[ $verbose -eq 1 ]]; then
      echo "ignoring '$file'."
    fi
    continue
  fi

  imv "$target/$file"

  new_name=$(get_rename "$file")
  if [[ -z $new_name ]]; then
    echo "done."
    exit
  fi

  if [[ $copy -eq 1 ]]; then
    cp "$target/$file" "$out/$new_name"
  else
    mv "$target/$file" "$out/$new_name"
  fi

  if [[ $verbose -eq 1 ]]; then
    if [[ $copy -eq 1 ]]; then
      echo "copied '$file' into '$new_name'."
    else
      echo "moved '$file' to '$new_name'."
    fi
  fi
done
