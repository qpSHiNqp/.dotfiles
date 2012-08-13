# PROMPT

case ${UID} in
0)
  PROMPT="%B%{[34m%}%/#%{[m%}%b "
  PROMPT2="%B%{[34m%}%_#%{[m%}%b "
  SPROMPT="%B%{[31m%}%r ? [n,y,a,e]:%{[m%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
	PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT="%{[34m%}%/%%%{[m%} "
  PROMPT2="%{[34m%}%_%%%{[m%} "
  SPROMPT="%{[31m%}%r ? [n,y,a,e]:%{[m%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
	PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
  ;;
esac 
RPROMPT="%T"                      # 右側に時間を表示する
setopt transient_rprompt          # 右側まで入力がきたら時間を消す
setopt prompt_subst               # 便利なプロント

case "${TERM}" in
kterm*|xterm)
	precmd() {
		echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
;;
esac

bindkey -e                        # emacsライクなキーバインド

export LANG=ja_JP.UTF-8           # 日本語環境
export EDITOR=vim                 # エディタはvim


autoload -U compinit              # 強力な補完機能
compinit -u                       # このあたりを使わないとzsh使ってる意味なし
setopt auto_pushd		          # cdの履歴を表示
setopt pushd_ignore_dups          # 同ディレクトリを履歴に追加しない
setopt auto_cd                    # 自動的にディレクトリ移動
setopt list_packed 		  # リストを詰めて表示
setopt list_types                 # 補完一覧ファイル種別表示

setopt correct


# 履歴
HISTFILE=~/.zsh_history           # historyファイル
HISTSIZE=50000                    # ファイルサイズ
SAVEHIST=50000                    # saveする量
setopt hist_ignore_dups           # 重複を記録しない
setopt hist_reduce_blanks         # スペース排除
setopt share_history              # 履歴ファイルを共有
setopt EXTENDED_HISTORY           # zshの開始終了を記録

# history 操作まわり
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey ";5C" forward-word
bindkey ";5D" backward-word

# alias
#export LS_COLORS='di=01;33;40'
    export LSCOLORS=exfxcxdxbxegedabagacad
#    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

alias ls="ls -G"
alias l="ls"
alias ll="ls -la"
alias la="ls -a"
alias ipv6="ip -6"
alias mtr="sudo mtr -t"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

zstyle ':completion:*:default' menu select=1

# PATH
#export PATH=/usr/local/bin:${PATH}

[ -f ~/.zshrc.include ] && source ~/.zshrc.include # 設定ファイルのinclude