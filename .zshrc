load_if_exists () { [ -f $1 ] && source $1 }

load_if_exists "$HOME/.dotfiles/.zsh_prompts"

bindkey -e                        # emacsライクなキーバインド
export LANG=ja_JP.UTF-8           # 日本語環境
export LANGUAGE=ja_JP.UTF-8       # 日本語環境
export LC_ALL=ja_JP.UTF-8
export EDITOR=vim                 # エディタはvim
autoload -U compinit              # 強力な補完機能
compinit -u                       # このあたりを使わないとzsh使ってる意味なし
setopt auto_pushd                 # cdの履歴を表示
setopt pushd_ignore_dups          # 同ディレクトリを履歴に追加しない
setopt list_packed                # リストを詰めて表示
setopt list_types                 # 補完一覧ファイル種別表示
setopt noautoremoveslash          # 勝手に消されると面倒
setopt correct                    # もしかして: 機能
setopt nonomatch
setopt auto_cd                    # 自動的にディレクトリ移動
cdpath=(~/Work ~/Work/repos)      # Work dir
setopt rm_star_wait               # 事故防止

# 履歴
HISTFILE=~/.zsh_history           # historyファイル
HISTSIZE=50000                    # ファイルサイズ
SAVEHIST=50000                    # saveする量
setopt hist_reduce_blanks         # スペース排除
setopt share_history              # 履歴ファイルを共有
setopt extended_history           # zshの開始終了を記録

# history 操作まわり
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey ";5C" forward-word
bindkey ";5D" backward-word

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1

# aliases
if [[ ${OSTYPE} =~ ^darwin ]] ; then
  alias ls="ls -G"
  alias rm="rm -v"
elif [[ ${OSTYPE} =~ ^linux-gnu ]] ; then
  alias ls="ls --color=auto"
fi

alias l="ls"
alias ll="ls -la"
alias la="ls -a"
alias mv="mv -i"
alias cp="cp -i"

alias jst='TZ=Asia/Tokyo date'
alias pst='TZ=US/Pacific date'
alias utc='TZ=UTC date'
alias p="ps aux | head -n 1 && ps aux | grep"
alias passwdgen="date +%s | shasum | base64 | head -c 16 ; echo"

# 環境依存系
for file in $HOME/.zsh_includes/*; do
  source "$file"
done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
