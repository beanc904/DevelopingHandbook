# Color definitions
_all_off="$(tput sgr0)"
_bold="${_all_off}$(tput bold)"
_black="${_bold}$(tput setaf 0)"
_red="${_bold}$(tput setaf 1)"
_green="${_bold}$(tput setaf 2)"
_yellow="${_bold}$(tput setaf 3)"
_blue="${_bold}$(tput setaf 4)"
_magenta="${_bold}$(tput setaf 5)"
_cyan="${_bold}$(tput setaf 6)"
_white="${_bold}$(tput setaf 7)"

# Colored makepkg-like output functions

note() {
    printf "${_blue}==>${_yellow} NOTE:${_bold} %s${_all_off}\n" "$1"
}

msg() {
    printf "${_blue}==>${_bold} %s${_all_off}\n" "$1"
}

msg2() {
    printf "${_blue}  ->${_bold} %s${_all_off}\n" "$1"
}

warning() {
    printf "${_yellow}==> WARNING:${_bold} %s${_all_off}\n" "$1"
}

error() {
    printf "${_red}==> ERROR:${_bold} %s${_all_off}\n" "$1"
}

plain() {
    printf "${_bold}%s${_all_off}\n" "$1"
}

success() {
    printf "${_green}==> SUCCESS:${_bold} %s${_all_off}\n" "$1"
}

