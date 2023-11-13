target=$(pwd)
out=$(pwd)
verbose=0
copy=0

function abort () {
  echo "[!]: $1"
  exit 1
}

function show_help () {
  echo "
  retag - Renomeia imagens baseado no conteúdo.

  Flags: (<path> é o diretório atual por padrão.)
  -d <path>: Lê os arquivos em <path>.
  -o <path>: Coloca os arquivos em <path>.
  -c: Mantém uma cópia do original.
  -v: Exibe verbose.
  --help / -h: Exibe essa mensagem.
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
        abort "'-d' deve ser um diretório."
      fi

      target=$next
    else
      abort "'-d' requer valor."
    fi
  fi

  if [[ $arg == "-o" ]]; then
    if [[ $next ]]; then
      if [[ ! -d $next ]]; then
        abort "'-o' deve ser um diretório."
      fi

      out=$next
    else
      abort "'-o' requer valor."
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
    --title="Renomeando '$1'" \
    --text="Novo nome:" \
    --cancel-label="Cancelar" 2> /dev/null
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
    echo "feito."
    exit
  fi

  if [[ $copy -eq 1 ]]; then
    cp "$target/$file" "$out/$new_name"
  else
    mv "$target/$file" "$out/$new_name"
  fi

  if [[ $verbose -eq 1 ]]; then
    if [[ $copy -eq 1 ]]; then
      echo "copiado '$file' pra '$new_name'."
    else
      echo "movido '$file' pra '$new_name'."
    fi
  fi
done
