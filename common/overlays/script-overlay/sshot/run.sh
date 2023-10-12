mode=""
silent=0
out=""

for ((i=1; i <= $#; i++)); do
  arg="${!i}"

  if [[ $arg == "--screen" ]]; then
    mode="screen"
  elif [[ $arg == "--area" ]]; then
    mode="area"
  elif [[ $arg == "-s" ]]; then
    silent=1
  elif [[ $arg == "-o" ]]; then
    fname_i=$((++i))
    fname="${!fname_i}"

    if [[ -n $fname ]]; then
      if [[ -d $fname ]]; then
        out=$fname
      else
        echo "error: '-o' output is not a directory."
        exit 1
      fi
    else
      echo "error: '-o' flag was provided but without any value."
      exit 1
    fi
  fi
done

if [[ -z $mode ]]; then
  echo "missing mode. (either --screen or --area)"
  exit 1
fi

if [[ -z $out ]]; then
  out=$HOME
fi

filename="$out/$(date -Ins)"

if [[ $mode == "screen" ]]; then
  grim "$filename"
elif [[ $mode == "area" ]]; then
  area=$(slurp)
  grim -g "$area" - | tee "$filename">/dev/null
fi

if [[ $silent == 0 ]]; then
  notify-send -t 3000 "Saved $mode capture to $filename."
fi
