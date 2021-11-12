function extract() {
    local remove_archive
    local success
    local file_name
    local extract_dir

    if (( $# == 0 )); then
	echo "Usage: extract [-option] [file ...]"
	echo
	echo Options:
	echo " -r, --remove Remove archive."
	echo
	echo "Report bugs to <sorin.ionescu@gmail.com>."
    fi

    remove_archive=1
    if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
	remove_archive=0
	shift
    fi

    while (( $# > 0 )); do
	if [[ ! -f "$1" ]]; then
	    echo "extract: '$1' is not a valid file" 1>&2
	    shift
	    continue
	fi

	success=0
	file_name="$( basename "$1" )"
	extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
	case "$1" in
	    (*.tar.gz|*.tgz) tar xvzf "$1" ;;
	    (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
	    (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
		&& tar --xz -xvf "$1" \
		|| xzcat "$1" | tar xvf - ;;
	    (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
		&& tar --lzma -xvf "$1" \
		|| lzcat "$1" | tar xvf - ;;
	    (*.tar) tar xvf "$1" ;;
	    (*.gz) gunzip "$1" ;;
	    (*.bz2) bunzip2 "$1" ;;
	    (*.xz) unxz "$1" ;;
	    (*.lzma) unlzma "$1" ;;
	    (*.Z) uncompress "$1" ;;
	    (*.zip) unzip "$1" -d $extract_dir ;;
	    (*.rar) unrar x -ad "$1" ;;
	    (*.7z) 7za x "$1" ;;
	    (*.deb)
		mkdir -p "$extract_dir/control"
		mkdir -p "$extract_dir/data"
		cd "$extract_dir"; ar vx "../${1}" > /dev/null
		cd control; tar xzvf ../control.tar.gz
		cd ../data; tar xzvf ../data.tar.gz
		cd ..; rm *.tar.gz debian-binary
		cd ..
		;;
	    (*)
		echo "extract: '$1' cannot be extracted" 1>&2
		success=1
		;;
	esac

	(( success = $success > 0 ? $success : $? ))
	(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
	shift
    done
}

alias x=extract


archive() {
    local success
    local remove_source=0
    if [ $# -eq 0 ]; then
	echo "USAGE : archive [options] files..."
	echo ""
	echo "\t-r,--remove\tremove source file"
	echo ""
    fi
    if [ "$1" = "-r" ] || [ "$1" = "--remove" ]; then
	remove_source=1
	shift
    fi
    while (( $# > 0 ))
    do
	tar cjvf "$1".tar.bz2 "$1"
	success=$?
	if [ $remove_source -eq 1 ] && [ $success -eq 0 ]; then
	    rm -rf "$1"
	fi
	if [ $success -ne 0 ]; then
	    echo "Erreur lors de l'opération d'archivage sur le fichier : $1"
	    break
	fi
	shift
    done
}

pause() {
  if $(killall -SIGSTOP $1); then
    echo "[+] $1 successfully paused";
  else
    echo "[-] Fail to pause $1";
  fi
}

unpause() {
  if $(killall -SIGCONT $1); then
    echo "[+] Successfully unpaused $1";
  else
    echo "[-] Failed to unpause $1";
  fi
}

function ssht() {
  local out
  first=$1
  shift
  for srv in "$@"; do
    out="${out}tmux split-window 'ssh $srv';"
  done
  out="${out}tmux select-layout even-vertical;"
  out="${out}ssh $first;"
  eval $out
}

# function that infer connection to multiple instance of the same type
# admin app-server 3
# is equivalent to
# ssht app-server1 app-server2 app-server3
function admin() {
  local server
  local number
  local out
  server=$1
  number=$2
  for i in $(seq $number); do
    out="${out} ${server}$i"
  done
  echo -ne "$out"
  ssht ${out}
}

function vsphere() {
  docker run --rm -it lamw/rvc rvc ara@37.187.228.30
}

# find in platform repository
function sf() {
  local args=$@
  #cd $(rg /home/nrm/dev/git/github.com/SekoiaLab/platform --files --null | xargs -0 dirname | awk '!h[$0]++' |fzf -q "${args} ")
  cd $(fd . --type d /home/nrm/dev/git/github.com/SekoiaLab/platform | fzf --query "${args} " --select-1 --exit-0)
}

# openstack context change function
unset OS_CLOUD
osctx () {
  source <(gopass ls --flat | grep openrc.sh | rofi -dmenu | xargs --no-run-if-empty gopass show -n)
}

# new kctx function
if [ -f ~/.kube.env ]; then source ~/.kube.env; fi
kctx() {
  local args=$1
  conf=$HOME/.kube/configs/$(ls $HOME/.kube/configs | fzf --query "${args}" --select-1 --exit-0)
  if [ -f "${conf}" ]; then
    export KUBECONFIG="${conf}"
    echo "export KUBECONFIG=${conf}" > $HOME/.kube.env
  fi
}

