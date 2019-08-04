# load utilities
. $ZDOTDIR/utils/core.zsh # enable load function
load $DOTPATH/lib/utilities.sh

if [[ -z ${DEBUG:-} ]]; then
  export DEBUG=0
fi

if is_debug; then
  log_info "profiling..."
  zmodload zsh/zprof && zprof
fi

# timezone
export TZ="Asia/Tokyo"

# locale
export LANGUAGE="ja_JP.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# zsh core packages
if [[ -z "${ZPLUG_HOME:-}" ]]; then
  export ZPLUG_HOME=$HOME/.zplug
fi
if [[ -z "${ZPLUG_LOADFILE:-}" ]]; then
  export ZPLUG_LOADFILE=$ZDOTDIR/utils/zplug.zsh
fi

# XDG Base Directory Specification
# @see https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# Homebrew Cask Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if (($+commands[nvim])); then
  export EDITOR=nvim
  export GIT_EDITOR="${EDITOR}"
fi

# Shell configuration
if is_osx; then
  export SHELL=/usr/local/bin/zsh
elif is_linux; then
  export SHELL="$(brew --prefix)/bin/zsh"
fi

# anyenv
# see: https://github.com/anyenv/anyenv
export ANYENV_ROOT=$HOME/.anyenv

# Helm
export HELM_HOME=$HOME/.helm

local creds="$HOME/.local/secrets"
if [[ ! -e "$creds" ]]; then
  touch "$creds"
  log_pass "create local credentials file - $creds."
else
  . $creds
fi

# log_pass "Loading complete .zshenv"
