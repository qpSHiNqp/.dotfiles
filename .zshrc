# hostname coloring
ip2color()
{
	IFCONF='/sbin/ifconfig'
	int=`netstat -rn | grep -Ei '^(default|(0\.){3}0)' \
		| sed -n "1 p" | awk '{ print $NF }'`
	ip4oc=`${IFCONF} ${int} | grep -E '[0-9]{1,3}(\.[0-9]{1,3}){3}' \
		| awk '/inet/{ print $2 }' | sed -e 's/\./\ /g' | awk '{print $4}'`
	[ $ip4oc  = '255' ] &&
		  ip4oc=`${IFCONF} $int | awk '/inet[^6]/{ print $1 }' \
		| sed -e 's/.*\.\([0-9]\{1,3\}\).*/\1/g'`

	return `expr $(expr $ip4oc % 7) + 1`
}

# PROMPT
set_prompt()
{
	if test $# -eq 1
	then
		col=$1
	else
		col=33
	fi

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
}

ip2color
set_prompt $?


# vcs_info (display branch name)
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
autoload -Uz is-at-least
if is-at-least 4.3.10; then
	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ':vcs_info:git:*' stagedstr "+"
	zstyle ':vcs_info:git:*' unstagedstr "-"
	zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
	zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
fi
precmd () {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	psvar[2]=$(_git_not_pushed)
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

function _git_not_pushed()
{
	if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
		head="$(git rev-parse HEAD)"
		for x in $(git rev-parse --remotes)
		do
			if [ "$head" = "$x" ]; then
				return 0
			fi
		done
		echo "{?}"
	fi
	return 0
}
RPROMPT="%1(v|%F{green}%1v%2v%f|)${vcs_info_git_pushed}${WINDOW:+"[$WINDOW]"} ${RESET}"

# RPROMPT other settings
RPROMPT="${RPROMPT} %T"           # 右側に時間を表示する
setopt transient_rprompt          # 右側まで入力がきたら時間を消す
setopt prompt_subst               # 便利なプロント

# terminal settings
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
	alias ls="ls --color=auto"
fi
alias l="ls"
alias ll="ls -la"
alias la="ls -a"
alias ipv6="ip -6"
alias mtr="sudo mtr -t"
alias e="vim"
alias mv="mv -i"
alias cp="cp -i"
alias p="ps aux | head -n 1 && ps aux | grep"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1

# PATH
export PATH=/usr/local/sbin:/sbin:/usr/sbin:/usr/local/bin:${PATH}
test -x /usr/local/mysql && export PATH=/usr/local/mysql/bin:${PATH}
test -x /Applications/adt-bundle-mac-x86_64 && export PATH=/usr/local/git/bin:/Applications/adt-bundle-mac-x86_64/sdk/tools:/Applications/adt-bundle-mac-x86_64/sdk/platform-tools:${PATH}
test -x /usr/local/git && export PATH=/Applications/adt-bundle-mac-x86_64/sdk:${PATH}
PHP_EXISTS='0'
test -x /usr/local/bin/brew && PHP_EXISTS=`brew list | grep php | wc -l | awk '{print $1}'`
test $PHP_EXISTS -ne '0' && export PATH=`brew --prefix php`/bin:${PATH}
test -x /usr/local/share/npm/bin && export PATH=/usr/local/share/npm/bin:${PATH}
test -x /usr/local/depot_tools && export PATH=/usr/local/depot_tools:${PATH}

if test -r ~/.zsh_includes/motd
then
	source ~/.zsh_includes/motd
fi
[ -z "${REMOTEHOST}${SSH_CONNECTION}" ] && [ -r ~/.rvm ] &&
	source ~/.zsh_includes/rvm

test -x ~/.nvm && source ~/.nvm/nvm.sh
