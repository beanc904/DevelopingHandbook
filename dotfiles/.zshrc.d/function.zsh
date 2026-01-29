# Description: Change directory to the one specified by yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Description: Enable | Disable the global proxy
function proxy() {
  source "$HOME/.zshrc.d/custom.sh/msg-color.sh"

  if [[ $1 == "on" ]]; then
    export https_proxy=http://127.0.0.1:7897
    export http_proxy=http://127.0.0.1:7897
    export all_proxy=socks5://127.0.0.1:7897
    success "Terminal proxy has been enabled"
  elif [[ $1 == "off" ]]; then
    unset http_proxy https_proxy all_proxy
    success "Terminal proxy has been disabled"
  else
    error "Usage: proxy [on|off]"
  fi
}

