msg() {
  if [[ $# -eq 0 ]]; then
    printf "\n"
    return 0
  fi

  local msg_t=""
  local msg_s=""

  local lbl_s=""

  local lb="\n"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --done)
        msg_t="DONE"
        lbl_s="\033[1;32m"
        ;;
      --fail)
        msg_t="FAIL"
        lbl_s="\033[1;31m"
        ;;
      --info)
        msg_t="INFO"
        lbl_s="\033[1;33m"
        ;;

      -[!-]*)
        local flags="${1#-}"

        if [[ "$flags" =~ ([0-7]) ]]; then
          msg_s="${msg_s}\033[3${BASH_REMATCH[1]}m"
        fi

        if [[ "$flags" =~ b ]]; then msg_s="${msg_s}\033[1m"; fi

        if [[ "$flags" =~ n ]]; then lb=""; fi
        ;;

      *) break ;;
    esac

    shift
  done

  local msg="${1:-}"

  local r="\033[0m"

  if [[ -n "$msg_t" ]]; then
    printf "${lbl_s}[${msg_t}]${r} ${msg_s}${msg}${r}${lb}"
  else
    printf "${msg_s}${msg}${r}${lb}"
  fi
}
