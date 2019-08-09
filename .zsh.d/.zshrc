if [[ $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]]; then
  zcompile $ZDOTDIR/.zshrc
fi

umask 022
typeset -gx -U path PATH

path=( \
  /usr/local/bin(N-/) \
  $HOME/bin(N-/) \
  $HOME/src/bin(N-/) \
  /usr/local/sbin(N-/) \
  "$path[@]" \
)

: "common configuration" && {
  autoload -Uz colors
  colors
  setopt correct
  setopt nobeep
  setopt no_tify
  setopt auto_pushd
  setopt auto_cd
  setopt interactive_comments
  setopt ignoreeof
  setopt no_flow_control
  setopt complete_in_word
  : "completion" && {
    _zpcompinit_custom
    zstyle ':completion:*:default' menu select=1
    zstyle ':completion::complete:*' use-cache true
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*:*:docker:*' option-stacking yes
    zstyle ':completion:*:*:docker-*:*' option-stacking yes
    if [[ -n "$LS_COLORS" ]]; then
        zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    fi

    : "for k8s" && {
      source <(kubectl completion zsh)
      complete -o default -F __start_kubectl k
     }
  }
}

: "help command configuration" && {
  autoload -Uz run-help
  autoload -Uz run-help-git
}

: "configuration for history" && {
  HISTFILE=$HOME/.zhistory
  HISTSIZE=100000
  SAVEHIST=100000
  setopt hist_ignore_dups
  setopt hist_ignore_all_dups
  setopt share_history
  setopt hist_no_store
  setopt hist_reduce_blanks
  setopt hist_verify
}

: "loading modules" && {
  declare -ax load_paths=(
    $ZPLUG_HOME/init.zsh\
    $ZDOTDIR/utils/env.zsh\
    $ZDOTDIR/utils/functions.zsh\
    $ZDOTDIR/utils/key_bindings.zsh\
    $ZDOTDIR/utils/tmux.zsh
  )

  for load_path in ${load_paths[@]}; do
    load $load_path
    log_pass "Loading complete $(basename $load_path)"
  done
}

# attach tmux session.
tmux_automatically_attach_session

if is_debug; then
  if (which zprof > /dev/null); then
    zprof | less
  fi
fi

log_pass "Loading complete .zshrc"
