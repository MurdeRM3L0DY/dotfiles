# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://z.digitalclouds.dev/docs/ecosystem/annexes
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes # <- https://z.digitalclouds.dev/docs/ecosystem/annexes
# examples here -> https://z.digitalclouds.dev/docs/gallery/collection
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands

zi ice lucid atload"_zsh_autosuggest_start"
zi light zsh-users/zsh-autosuggestions

zi ice depth=1
zi light romkatv/powerlevel10k

# SYNTAX HIGHLIGHTING

zi wait lucid for \
 atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/fast-syntax-highlighting

# sdkman
zi ice as'program' pick'$ZPFX/sdkman/bin/sdk' id-as'sdkman' run-atpull \
  atclone'curl -s "https://get.sdkman.io" | bash' \
  atpull'sdk selfupdate' \
  atinit'export SDKMAN_DIR=$ZPFX/sdkman; source $SDKMAN_DIR/bin/sdkman-init.sh;'
zi light z-shell/null

# pyenv
zi ice atclone'source $ZDOTDIR/pyenv/atclone.zsh;' \
  atpull"%atclone" \
  atinit'source $ZDOTDIR/pyenv/atinit.zsh;' \
  as'command' \
  pick'bin/pyenv' \
  nocompile'!'
zi light pyenv/pyenv

#FNM
export ZSH_FNM_NODE_VERSION="16.7.0"
zi light "dominik-schwabe/zsh-fnm"

# FZF
zi ice from"gh-r" as"command"
zi light junegunn/fzf

# FZF-TAB
zi light Aloxaf/fzf-tab

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# EXA
zi ice lucid from"gh-r" as"program" mv"bin/exa* -> exa" atload"alias ls='exa -lah'"
zi light ogham/exa
# zi ice wait blockf atpull'zinit creinstall -q .'

# DELTA
zi ice lucid wait"0" as"program" from"gh-r" pick"delta*/delta"
zi light dandavison/delta

# DUST
zi ice lucid from"gh-r" as"program" mv"dust*/dust -> dust" pick"dust" atload"alias du=dust"
zi light bootandy/dust

# DUF
zi ice lucid wait"0" as"program" from"gh-r" bpick='*linux_amd64.deb' pick"usr/bin/duf" atload"alias df=duf"
zi light muesli/duf

# BAT
zi ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
zi light sharkdp/bat

# RIPGREP
zi ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zi light BurntSushi/ripgrep

# FORGIT
zi ice wait lucid
zi load wfxr/forgit

# FD
zi ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zi light sharkdp/fd

# GH-CLI
zi ice lucid wait"0" as"program" from"gh-r" pick"usr/bin/gh"
zi light cli/cli

# ZSH MANYDOTS MAGIC
zi autoload'#manydots-magic' for knu/zsh-manydots-magic

# PRETTYPING
zi ice lucid wait'' as"program" pick"prettyping" atload'alias ping=prettyping'
zi load denilsonsa/prettyping

# GLOW
zi ice lucid wait"0" as"program" from"gh-r" bpick='*linux_amd64.deb' pick"usr/bin/glow"
zi light charmbracelet/glow

#####################
# HISTORY           #
#####################
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zhistory"
HISTSIZE=290000
SAVEHIST=$HISTSIZE

#####################
# SETOPT            #
#####################
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
# setopt completealiases        # complete alisases
# setopt always_to_end          # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word       # allow completion from within a word/phrase
setopt nocorrect                # spelling correction for commands
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
setopt autocd
unsetopt BEEP

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
