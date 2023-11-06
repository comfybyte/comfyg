mkdir -p "$out"/share/fonts/truetype
for file in $(ls "$src"/ttf | grep .ttf); do nerd-font-patcher -c -q --out "$out"/share/fonts/truetype "$src"/ttf/"$file"; done;
