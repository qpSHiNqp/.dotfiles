# PROMPT

IFCONF='/sbin/ifconfig'

int=`netstat -rn | grep -Ei '^(default|(0\.){3}0)' | sed -n "1 p" | awk '{ print $NF }'`
ip4oc=`${IFCONF} ${int} | grep -E '[0-9]{1,3}(\.[0-9]{1,3}){3}' | awk '/inet/{ print $2 }' | sed -e 's/\./\ /g' | awk '{print $4}'`
[ $ip4oc  = '255' ] &&
	  ip4oc=`${IFCONF} $int | awk '/inet[^6]/{ print $1 }' | sed -e 's/.*\.\([0-9]\{1,3\}\).*/\1/g'`

col=`expr $(expr $ip4oc % 7) + 1 `

case ${UID} in
0)
  PROMPT="%B%{[34m%}%/#%{[m%}%b "
  PROMPT2="%B%{[34m%}%_#%{[m%}%b "
  SPROMPT="%B%{[31m%}%r ? [n,y,a,e]:%{[m%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
	PROMPT="[%{[3${col}m%}${HOST%%.*}%{[0m%}] ${PROMPT}"
  ;;
*)
  PROMPT="%{[34m%}%/%%%{[m%} "
  PROMPT2="%{[34m%}%_%%%{[m%} "
  SPROMPT="%{[31m%}%r ? [n,y,a,e]:%{[m%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
	PROMPT="[%{[3${col}m%}${HOST%%.*}%{[0m%}] ${PROMPT}"
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

#export LANG=ja_JP.UTF-8           # 日本語環境
export EDITOR=vim                 # エディタはvim


autoload -U compinit              # 強力な補完機能
compinit -u                       # このあたりを使わないとzsh使ってる意味なし
setopt auto_pushd		          # cdの履歴を表示
setopt pushd_ignore_dups          # 同ディレクトリを履歴に追加しない
setopt auto_cd                    # 自動的にディレクトリ移動
setopt list_packed 		  # リストを詰めて表示
setopt list_types                 # 補完一覧ファイル種別表示
setopt noautoremoveslash

setopt correct
setopt nonomatch


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

if [[ ${OSTYPE} =~ ^darwin ]] ; then
	alias ls="ls -G"
elif [[ ${OSTYPE} =~ ^linux-gnu ]] ; then
	alias ls="ls --color=autl"
fi
alias l="ls"
alias ll="ls -la"
alias la="ls -a"
alias ipv6="ip -6"
alias mtr="sudo mtr -t"
alias e="vim"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1

# PATH
export PATH=/usr/local/mysql/bin:/sbin:/usr/sbin:/usr/local/bin:${PATH}
test -x /usr/local/bin/brew && export PATH=`brew --prefix php`/bin:${PATH}

source ~/.zsh_includes/motd
[ -z "${REMOTEHOST}${SSH_CONNECTION}" ] && 
	source ~/.zsh_includes/rvm
