target=$(pwd)
out=$(pwd)
verbose=0
copy=0
all=0

function abort () {
  echo "[!]: $1"
  exit 1
}

function show_help () {
  echo "
  retag - Tool for renaming files based on content (peek and prompt rename).

  Flags: (<path> defaults to current)
  -d <path>: Where to read files from.
  -o <path>: Where to place files.
  -c: Copy instead of move.
  -a: Reads all files at -d, instead of only files with commonly used image extensions (.png, .jpg, ...).
  -v: Verbose.
  --help / -h: Displays this message.
  "
}

for ((i=0; i <= $#; i++)); do
  arg="${!i}"
  next_i=$((i+1))
  next=""
  if [[ $next_i -lt $# ]]; then
    next="${!next_i}"
  fi

  if [[ $arg == "--help" || $arg == "-h" ]]; then
    show_help
    exit 0
  fi

  if [[ $arg == "-d" ]]; then
    if [[ $next ]]; then
      if [[ ! -d $next ]]; then
        abort "'-d' expected directory."
      fi

      target=$next
    else
      abort "'-d' expected value."
    fi
  fi

  if [[ $arg == "-o" ]]; then
    if [[ $next ]]; then
      if [[ ! -d $next ]]; then
        abort "'-o' expected directory."
      fi

      out=$next
    else
      abort "'-o' expected value."
    fi
  fi

  if [[ $arg == "-v" ]]; then
    verbose=1
  fi

  if [[ $arg == "-c" ]]; then
    copy=1
  fi

  if [[ $arg == "-a" ]]; then
    all=1
  fi
done

function get_rename () {
  zenity --entry \
    --title="Renaming '$1'" \
    --text="New name (leave empty to skip):" \
    --cancel-label="Stop" 2> /dev/null
}

function may_be_image () {
  ext=${1##*.}
  [ "$ext" ] && { [ "$ext" == "png" ] || [ "$ext" == "jpg" ] || [ "$ext" == "jpeg" ] || [ "$ext" == "gif" ]; }
}

if [[ $all -eq 1 && $verbose -eq 1 ]]; then
  echo "'-a' flag in use, reading all files."
fi

for filepath in "$target"/*; do
  file=$(basename "$filepath")

  if [[ $all -eq 0 ]] && ! may_be_image "$file"; then
    if [[ $verbose -eq 1 ]]; then
      echo "ignoring '$file'."
    fi
    continue
  fi

  imv "$target/$file"

  new_name=$(get_rename "$file")
  if [[ -z $new_name ]]; then
    echo "skipping '$file'."
    continue
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
