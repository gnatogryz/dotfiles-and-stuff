alias gitk="gitk --all"
eval "$(thefuck --alias)"

# alias mp4webm="ffmpeg -f webm -c:v libvpx -b:v 1M -acodec libvorbis example.webm -hide_banner -i "

# command not found
# source /usr/share/doc/pkgfile/command-not-found.bash

# open file in default gui app
alias xxx="xdg-open"

md () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

alias nr="npm run"
alias c="code ."

alias pacman="sudo pacman"

# Tilix fix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# autojump
source /etc/profile.d/autojump.bash

# autoCD
shopt -s autocd

# Archlinux Ultimate Install - .bashrc
# by helmuthdu
# OVERALL CONDITIONALS {{{
_islinux=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && _islinux=true

_isarch=false
[[ -f /etc/arch-release ]] && _isarch=true

_isxrunning=false
[[ -n "$DISPLAY" ]] && _isxrunning=true

_isroot=false
[[ $UID -eq 0 ]] && _isroot=true
# }}}
# PS1 CONFIG {{{
  export TERM='xterm-256color'

  if $_isxrunning; then
    [[ -f $HOME/.dircolors_256 ]] && eval $(dircolors -b $HOME/.dircolors_256)

     B='\[\e[1;38;5;33m\]'
    LB='\[\e[1;38;5;81m\]'
    GY='\[\e[1;38;5;242m\]'
     G='\[\e[1;38;5;82m\]'
     P='\[\e[1;38;5;161m\]'
    PP='\[\e[1;38;5;93m\]'
     R='\[\e[1;38;5;196m\]'
     Y='\[\e[1;38;5;214m\]'
     W='\[\e[0m\]'

    get_prompt_symbol() {
      [[ $UID == 0 ]] && echo "#" || echo "\$"
    }

    if [[ $PS1 && -f ~/.git-prompt.sh ]]; then
      source /usr/share/git/completion/git-completion.bash
      source ~/.git-prompt.sh

      export GIT_PS1_SHOWDIRTYSTATE=1
      export GIT_PS1_SHOWSTASHSTATE=1
      export GIT_PS1_SHOWUNTRACKEDFILES=0
      export GIT_PS1_SHOWUPSTREAM=auto

      export PS1=" $P┌─ $GY[$Y\u$GY@$P\h$GY:$B\w\$(__git_ps1 \"$GY  $LB%s\")$GY]\n $P└─ $W\$(get_prompt_symbol) "
    else
      export PS1="$GY[$Y\u$GY@$P\h$GY:$B\w$GY]\n$W\$(get_prompt_symbol) "
    fi
  else
    [[ -f $HOME/.dircolors ]] && eval $(dircolors -b $HOME/.dircolors)
  fi
#}}}
# BASH OPTIONS {{{
  shopt -s cdspell                 # Correct cd typos
  shopt -s checkwinsize            # Update windows size on command
  shopt -s histappend              # Append History instead of overwriting file
  shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
  shopt -s extglob                 # Extended pattern
  shopt -s no_empty_cmd_completion # No empty completion
  # COMPLETION {{{
    complete -cf sudo
    if [[ -f /etc/bash_completion ]]; then
      . /etc/bash_completion
    fi
  #}}}
#}}}
# CONFIG {{{
  export PATH=/usr/local/bin:$PATH
  if [[ -d "$HOME/bin" ]] ; then
      PATH="$HOME/bin:$PATH"
  fi
  # RUBY {{{
    if which ruby &>/dev/null; then
      GEM_DIR=$(ruby -r rubygems -e 'puts Gem.user_dir')/bin
      if [[ -d "$GEM_DIR" ]]; then
        export PATH=$GEM_DIR:$PATH
      fi
    fi
  #}}}
  # NVM {{{
    if [[ -f "/usr/share/nvm/nvm.sh" ]]; then
      source /usr/share/nvm/init-nvm.sh
    fi
  #}}}
  # CHRUBY {{{
    if [[ -f "/usr/share/chruby/chruby.sh" ]]; then
      source /usr/share/chruby/chruby.sh
    fi
  #}}}
  # VTE {{{
    if [[ $TERMINIX_ID ]]; then
      source /etc/profile.d/vte.sh
    fi
  #}}}
  # ANDROID SDK {{{
    if [[ -d "/opt/android-sdk" ]]; then
      export ANDROID_HOME=/opt/android-sdk
    fi
  #}}}
  # CHROME {{{
    if which google-chrome-stable &>/dev/null; then
      export CHROME_BIN=/usr/bin/google-chrome-stable
    fi
  #}}}
  # EDITOR {{{
    if which vim &>/dev/null; then
      export EDITOR="vim"
    elif which emacs &>/dev/null; then
      export EDITOR="emacs -nw"
    else
      export EDITOR="nano"
    fi
  #}}}
  # BASH HISTORY {{{
    # make multiple shells share the same history file
    export HISTSIZE=1000            # bash history will save N commands
    export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
    export HISTCONTROL=ignoreboth   # ingore duplicates and spaces
    export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history'
  #}}}
  # COLORED MANUAL PAGES {{{
    # @see http://www.tuxarena.com/?p=508
    # For colourful man pages (CLUG-Wiki style)
    if $_isxrunning; then
      export PAGER=less
      export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
      export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
      export LESS_TERMCAP_me=$'\E[0m'           # end mode
      export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
      export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
      export LESS_TERMCAP_ue=$'\E[0m'           # end underline
      export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
    fi
  #}}}
#}}}
# ALIAS {{{
  alias freemem='sudo /sbin/sysctl -w vm.drop_caches=3'
  # AUTOCOLOR {{{
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  #}}}
  # MODIFIED COMMANDS {{{
    alias ..='cd ..'
    alias df='df -h'
    alias diff='colordiff'              # requires colordiff package
    alias du='du -c -h'
    alias free='free -m'                # show sizes in MB
    alias grep='grep --color=auto'
    alias grep='grep --color=tty -d skip'
    alias mkdir='mkdir -p -v'
    alias more='less'
    alias nano='nano -w'
    alias ping='ping -c 5'
  #}}}
  # PRIVILEGED ACCESS {{{
    if ! $_isroot; then
      alias sudo='sudo '
      alias scat='sudo cat'
      alias svim='sudo vim'
      alias root='sudo su'
    fi
  #}}}
  # MULTIMEDIA {{{
    if which get_flash_videos &>/dev/null; then
      alias gfv='get_flash_videos -r 720p --subtitles'
    fi
  #}}}
  # LS {{{
    alias ls='lsd -hF'
    alias lr='lsd -R'                    # recursive ls
    alias ll='lsd -alh'
    alias la='ll -A'
    alias lm='la | less'
  #}}}
#}}}
# FUNCTIONS {{{
  # TOP 10 COMMANDS {{{
    # copyright 2007 - 2010 Christopher Bratusek
    top10() { history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head; }
  #}}}
  # UP {{{
    # Goes up many dirs as the number passed as argument, if none goes up by 1 by default
    up() {
      local d=""
      limit=$1
      for ((i=1 ; i <= limit ; i++)); do
        d=$d/..
      done
      d=$(echo $d | sed 's/^\///')
      if [[ -z "$d" ]]; then
        d=..
      fi
      cd $d
    }
  #}}}
  # ARCHIVE EXTRACTOR {{{
    extract() {
      clrstart="\033[1;34m"  #color codes
      clrend="\033[0m"

      if [[ "$#" -lt 1 ]]; then
        echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
        exit 1 #not enough args
      fi

      if [[ ! -e "$1" ]]; then
        echo -e "${clrstart}File does not exist!${clrend}"
        exit 2 #file not found
      fi

      if [[ -z "$2" ]]; then
        DESTDIR="." #set destdir to current dir
      elif [[ ! -d "$2" ]]; then
        echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
        read response
        #echo -e "\n"
        if [[ $response == y || $response == Y ]]; then
          mkdir -p "$2"
          if [ $? -eq 0 ]; then
            DESTDIR="$2"
          else
            exit 6 #Write perms error
          fi
        else
          echo -e "${clrstart}Closing.${clrend}"; exit 3 # n/wrong response
        fi
      else
        DESTDIR="$2"
      fi

      if [[ ! -z "$3" ]]; then
        if [[ "$3" != "v" ]]; then
          echo -e "${clrstart}Wrong argument $3 !${clrend}"
          exit 4 #wrong arg 3
        fi
      fi

      filename=`basename "$1"`

      #echo "${filename##*.}" debug

      case "${filename##*.}" in
        tar)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (uncompressed tar)${clrend}"
          tar x${3}f "$1" -C "$DESTDIR"
          ;;
        gz)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}fz "$1" -C "$DESTDIR"
          ;;
        tgz)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}fz "$1" -C "$DESTDIR"
          ;;
        xz)
          echo -e "${clrstart}Extracting  $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}f -J "$1" -C "$DESTDIR"
          ;;
        bz2)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (bzip compressed tar)${clrend}"
          tar x${3}fj "$1" -C "$DESTDIR"
          ;;
        zip)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (zipp compressed file)${clrend}"
          unzip "$1" -d "$DESTDIR"
          ;;
        rar)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (rar compressed file)${clrend}"
          unrar x "$1" "$DESTDIR"
          ;;
        7z)
          echo -e  "${clrstart}Extracting $1 to $DESTDIR: (7zip compressed file)${clrend}"
          7za e "$1" -o"$DESTDIR"
          ;;
        *)
          echo -e "${clrstart}Unknown archieve format!"
          exit 5
          ;;
      esac
    }
  #}}}
  # ARCHIVE COMPRESS {{{
    compress() {
      if [[ -n "$1" ]]; then
        FILE=$1
        case $FILE in
        *.tar ) shift && tar cf $FILE $* ;;
    *.tar.bz2 ) shift && tar cjf $FILE $* ;;
     *.tar.gz ) shift && tar czf $FILE $* ;;
        *.tgz ) shift && tar czf $FILE $* ;;
        *.zip ) shift && zip $FILE $* ;;
        *.rar ) shift && rar $FILE $* ;;
        esac
      else
        echo "usage: compress <foo.tar.gz> ./foo ./bar"
      fi
    }
  #}}}
  # REMIND ME, ITS IMPORTANT! {{{
    # usage: remindme <time> <text>
    # e.g.: remindme 10m "omg, the pizza"
    remindme() { sleep $1 && zenity --info --text "$2" & }
  #}}}
  # FILE & STRINGS RELATED FUNCTIONS {{{
    ## FIND A FILE WITH A PATTERN IN NAME {{{
      ff() { find . -type f -iname '*'$*'*' -ls ; }
    #}}}
    ## FIND A FILE WITH PATTERN $1 IN NAME AND EXECUTE $2 ON IT {{{
      fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
    #}}}
    ## MOVE FILENAMES TO LOWERCASE {{{
      lowercase() {
        for file ; do
          filename=${file##*/}
          case "$filename" in
          */* ) dirname==${file%/*} ;;
            * ) dirname=.;;
          esac
          nf=$(echo $filename | tr A-Z a-z)
          newname="${dirname}/${nf}"
          if [[ "$nf" != "$filename" ]]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
          else
            echo "lowercase: $file not changed."
          fi
        done
      }
  #}}}
    ## SWAP 2 FILENAMES AROUND, IF THEY EXIST {{{
      #(from Uzi's bashrc).
      swap() {
        local TMPFILE=tmp.$$

        [[ $# -ne 2 ]] && echo "swap: 2 arguments needed" && return 1
        [[ ! -e $1 ]] && echo "swap: $1 does not exist" && return 1
        [[ ! -e $2 ]] && echo "swap: $2 does not exist" && return 1

        mv "$1" $TMPFILE
        mv "$2" "$1"
        mv $TMPFILE "$2"
      }
    #}}}
    ## FINDS DIRECTORY SIZES AND LISTS THEM FOR THE CURRENT DIRECTORY {{{
      dirsize () {
        du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
        egrep '^ *[0-9.]*M' /tmp/list
        egrep '^ *[0-9.]*G' /tmp/list
        rm -rf /tmp/list
      }
    #}}}
    ## FIND AND REMOVED EMPTY DIRECTORIES {{{
      fared() {
        read -p "Delete all empty folders recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -type d -empty -exec rm -fr {} \; &> /dev/null
      }
    #}}}
  #}}}
  # ENTER AND LIST DIRECTORY{{{
    # function cd() { builtin cd -- "$@" && { [ "$PS1" = "" ] || ls -hrt --color; }; }
  #}}}
#}}}


### GNATBASH ###

alias dobrazmiana="commited"

gg() {
	echo wp
}

zmiana() {
	git commit -m "$*"
}

czekaut() {
	git checkout $*
}


pchaj() {
	git push
}

ssij() {
	git pull
	git submodule update --recursive
}

ssijkurwa() {
	git pull --recurse-submodules
	git submodule update --recursive --force
}

ssijnowe() {
	git pull --recurse-submodules
	git submodule update --recursive --remote --checkout
}

ssijnowekurwa() {
	git pull --recurse-submodules
	git submodule update --recursive --remote --checkout --force
}

co() {
	git status -s
}

wypierdalaj() {
	git reset --hard HEAD~1
}

refrash() {
	source ~/.bashrc
}


command_not_found_handle () {
    echo "[s[?25l[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▄[48;2;7;7;7m[38;2;27;27;27m▄[48;2;7;7;7m[38;2;103;103;103m▄[48;2;8;8;8m[38;2;173;173;173m▄[48;2;9;9;9m[38;2;206;206;206m▄[48;2;3;3;3m[38;2;250;250;250m▄[48;2;6;6;6m[38;2;189;189;189m▄[48;2;7;7;7m[38;2;88;88;88m▄[0;38;2;5;5;5m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▄[48;2;6;6;6m[38;2;78;78;78m▄[48;2;94;94;94m[38;2;253;253;253m▄[48;2;246;246;246m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;167;167;167m[38;2;254;254;254m▄[48;2;10;10;10m[38;2;132;132;132m▄[0;38;2;8;8;8m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [48;2;8;8;8m[38;2;6;6;6m▄[48;2;35;35;35m[38;2;199;199;199m▄[48;2;244;244;244m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;247;247;247m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;251;251;251m[38;2;255;255;255m▄[48;2;46;46;46m[38;2;148;148;148m▄[0;38;2;7;7;7m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [48;2;7;7;7m[38;2;6;6;6m▄[48;2;68;68;68m[38;2;170;170;170m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;244;244;244m▄[48;2;242;242;242m[38;2;39;39;39m▄[48;2;103;103;103m[38;2;0;0;0m▄[48;2;8;8;8m[38;2;0;0;0m▄[48;2;30;30;30m[38;2;150;150;150m▄[48;2;135;135;135m[38;2;80;80;80m▄[48;2;254;254;254m[38;2;174;174;174m▄[48;2;207;207;207m[38;2;244;244;244m▄[48;2;7;7;7m[38;2;4;4;4m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;5;5;5m▄[0;38;2;6;6;6m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [0;38;2;8;8;8m▄[48;2;3;3;3m[38;2;0;0;0m▄[48;2;93;93;93m[38;2;2;2;2m▄[48;2;138;138;138m[38;2;116;116;116m▄[48;2;236;236;236m[38;2;54;54;54m▄[48;2;255;255;255m[38;2;233;233;233m▄[48;2;255;255;255m[38;2;132;132;132m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;151;151;151m[38;2;72;72;72m▄[48;2;0;0;0m[38;2;0;0;0m▄[48;2;0;0;0m[38;2;0;0;0m▄[48;2;0;0;0m[38;2;8;8;8m▄[48;2;167;167;167m[38;2;239;239;239m▄[48;2;197;197;197m[38;2;166;166;166m▄[48;2;91;91;91m[38;2;81;81;81m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;63;63;63m[38;2;124;124;124m▄[48;2;6;6;6m[38;2;7;7;7m▄[m [m [m [m [m [m [m [m [m [m [m [m [48;2;6;6;6m[38;2;9;9;9m▄[48;2;63;63;63m[38;2;250;250;250m▄[48;2;68;68;68m[38;2;254;254;254m▄[48;2;10;10;10m[38;2;187;187;187m▄[0;38;2;8;8;8m▄[m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [48;2;8;8;8m[38;2;8;8;8m▄[48;2;0;0;0m[38;2;0;0;0m▄[48;2;0;0;0m[38;2;0;0;0m▄[48;2;0;0;0m[38;2;11;11;11m▄[48;2;205;205;205m[38;2;240;240;240m▄[48;2;68;68;68m[38;2;42;42;42m▄[48;2;27;27;27m[38;2;79;79;79m▄[48;2;165;165;165m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;59;59;59m[38;2;223;223;223m▄[48;2;7;7;7m[38;2;40;40;40m▄[48;2;49;49;49m[38;2;50;50;50m▄[48;2;161;161;161m[38;2;36;36;36m▄[48;2;166;166;166m[38;2;62;62;62m▄[48;2;25;25;25m[38;2;203;203;203m▄[48;2;192;192;192m[38;2;190;190;190m▄[48;2;255;255;255m[38;2;253;253;253m▄[48;2;173;173;173m[38;2;230;230;230m▄[48;2;8;8;8m[38;2;4;4;4m▄[m [m [m [m [m [m [m [m [m [m [m [m [48;2;16;16;16m[38;2;19;19;19m▄[48;2;254;254;254m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;30;30;30m[38;2;81;81;81m▄[m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [0;38;2;8;8;8m▀[48;2;0;0;0m[38;2;4;4;4m▄[48;2;16;16;16m[38;2;16;16;16m▄[48;2;125;125;125m[38;2;79;79;79m▄[48;2;59;59;59m[38;2;136;136;136m▄[48;2;2;2;2m[38;2;26;26;26m▄[48;2;164;164;164m[38;2;207;207;207m▄[48;2;91;91;91m[38;2;139;139;139m▄[48;2;50;50;50m[38;2;24;24;24m▄[48;2;237;237;237m[38;2;200;200;200m▄[48;2;253;253;253m[38;2;250;250;250m▄[48;2;202;202;202m[38;2;169;169;169m▄[48;2;207;207;207m[38;2;31;31;31m▄[48;2;165;165;165m[38;2;39;39;39m▄[48;2;34;34;34m[38;2;184;184;184m▄[48;2;26;26;26m[38;2;253;253;253m▄[48;2;242;242;242m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;46;46;46m[38;2;103;103;103m▄[48;2;7;7;7m[38;2;8;8;8m▄[m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▄[48;2;43;43;43m[38;2;67;67;67m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;250;250;250m▄[48;2;113;113;113m[38;2;122;122;122m▄[48;2;8;8;8m[38;2;9;9;9m▄[m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [48;2;8;8;8m[38;2;7;7;7m▄[48;2;177;177;177m[38;2;156;156;156m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;250;250;250m[38;2;254;254;254m▄[48;2;93;93;93m[38;2;238;238;238m▄[48;2;22;22;22m[38;2;148;148;148m▄[48;2;54;54;54m[38;2;53;53;53m▄[48;2;96;96;96m[38;2;17;17;17m▄[48;2;100;100;100m[38;2;109;109;109m▄[48;2;19;19;19m[38;2;199;199;199m▄[48;2;41;41;41m[38;2;254;254;254m▄[48;2;163;163;163m[38;2;255;255;255m▄[48;2;251;251;251m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;193;193;193m[38;2;250;250;250m▄[48;2;7;7;7m[38;2;10;10;10m▄[m [m [m [m [m [m [m [m [m [m [48;2;8;8;8m[38;2;7;7;7m▄[48;2;97;97;97m[38;2;138;138;138m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;227;227;227m[38;2;235;235;235m▄[48;2;156;156;156m[38;2;110;110;110m▄[48;2;105;105;105m[38;2;32;32;32m▄[0;38;2;7;7;7m▀[m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [48;2;7;7;7m[38;2;7;7;7m▄[48;2;119;119;119m[38;2;17;17;17m▄[48;2;144;144;144m[38;2;90;90;90m▄[48;2;62;62;62m[38;2;162;162;162m▄[48;2;7;7;7m[38;2;227;227;227m▄[48;2;63;63;63m[38;2;254;254;254m▄[48;2;166;166;166m[38;2;255;255;255m▄[48;2;247;247;247m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;225;225;225m▄[48;2;255;255;255m[38;2;222;222;222m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;94;94;94m[38;2;215;215;215m▄[48;2;7;7;7m[38;2;4;4;4m▄[m [m [m [m [m [0;38;2;7;7;7m▄[0;38;2;7;7;7m▄[0;38;2;5;5;5m▄[0;38;2;7;7;7m▄[48;2;7;7;7m[38;2;20;20;20m▄[48;2;187;187;187m[38;2;252;252;252m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;253;253;253m▄[48;2;181;181;181m[38;2;47;47;47m▄[48;2;6;6;6m[38;2;9;9;9m▄[48;2;7;7;7m[38;2;20;20;20m▄[48;2;1;1;1m[38;2;86;86;86m▄[48;2;9;9;9m[38;2;4;4;4m▄[m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [48;2;35;35;35m[38;2;5;5;5m▄[48;2;254;254;254m[38;2;231;231;231m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;209;209;209m[38;2;254;254;254m▄[48;2;90;90;90m[38;2;87;87;87m▄[48;2;192;192;192m[38;2;242;242;242m▄[48;2;46;46;46m[38;2;36;36;36m▄[48;2;254;254;254m[38;2;231;231;231m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;92;92;92m[38;2;228;228;228m▄[48;2;7;7;7m[38;2;7;7;7m▄[m [0;38;2;9;9;9m▄[48;2;8;8;8m[38;2;60;60;60m▄[48;2;13;13;13m[38;2;223;223;223m▄[48;2;91;91;91m[38;2;255;255;255m▄[48;2;189;189;189m[38;2;255;255;255m▄[48;2;228;228;228m[38;2;241;241;241m▄[48;2;104;104;104m[38;2;27;27;27m▄[48;2;103;103;103m[38;2;99;99;99m▄[48;2;255;255;255m[38;2;147;147;147m▄[48;2;255;255;255m[38;2;136;136;136m▄[48;2;211;211;211m[38;2;182;182;182m▄[48;2;82;82;82m[38;2;251;251;251m▄[48;2;95;95;95m[38;2;226;226;226m▄[48;2;142;142;142m[38;2;53;53;53m▄[48;2;93;93;93m[38;2;3;3;3m▄[48;2;27;27;27m[38;2;6;6;6m▄[48;2;12;12;12m[38;2;17;17;17m▄[0;38;2;6;6;6m▄[m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [48;2;7;7;7m[38;2;6;6;6m▄[48;2;172;172;172m[38;2;125;125;125m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;181;181;181m[38;2;236;236;236m▄[48;2;162;162;162m[38;2;93;93;93m▄[48;2;110;110;110m[38;2;180;180;180m▄[48;2;145;145;145m[38;2;76;76;76m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;75;75;75m[38;2;167;167;167m▄[48;2;6;6;6m[38;2;0;0;0m▄[48;2;58;58;58m[38;2;207;207;207m▄[48;2;246;246;246m[38;2;221;221;221m▄[48;2;61;61;61m[38;2;226;226;226m▄[48;2;97;97;97m[38;2;63;63;63m▄[48;2;102;102;102m[38;2;44;44;44m▄[48;2;15;15;15m[38;2;191;191;191m▄[48;2;52;52;52m[38;2;255;255;255m▄[48;2;84;84;84m[38;2;255;255;255m▄[48;2;103;103;103m[38;2;255;255;255m▄[48;2;103;103;103m[38;2;255;255;255m▄[48;2;65;65;65m[38;2;255;255;255m▄[48;2;27;27;27m[38;2;235;235;235m▄[48;2;133;133;133m[38;2;75;75;75m▄[48;2;253;253;253m[38;2;119;119;119m▄[48;2;249;249;249m[38;2;229;229;229m▄[48;2;243;243;243m[38;2;224;224;224m▄[48;2;254;254;254m[38;2;130;130;130m▄[48;2;42;42;42m[38;2;19;19;19m▄[m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▀[48;2;50;50;50m[38;2;5;5;5m▄[48;2;254;254;254m[38;2;231;231;231m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;75;75;75m[38;2;123;123;123m▄[48;2;243;243;243m[38;2;196;196;196m▄[48;2;20;20;20m[38;2;72;72;72m▄[48;2;244;244;244m[38;2;185;185;185m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;75;75;75m[38;2;233;233;233m▄[48;2;192;192;192m[38;2;153;153;153m▄[48;2;192;192;192m[38;2;255;255;255m▄[48;2;141;141;141m[38;2;48;48;48m▄[48;2;57;57;57m[38;2;207;207;207m▄[48;2;247;247;247m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;225;225;225m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;249;249;249m[38;2;255;255;255m▄[48;2;34;34;34m[38;2;138;138;138m▄[48;2;71;71;71m[38;2;5;5;5m▄[48;2;120;120;120m[38;2;7;7;7m▄[0;38;2;6;6;6m▀[0;38;2;10;10;10m▀[m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [48;2;6;6;6m[38;2;9;9;9m▄[48;2;136;136;136m[38;2;42;42;42m▄[48;2;255;255;255m[38;2;250;250;250m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;188;188;188m[38;2;247;247;247m▄[48;2;121;121;121m[38;2;40;40;40m▄[48;2;142;142;142m[38;2;187;187;187m▄[48;2;140;140;140m[38;2;90;90;90m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;217;217;217m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;243;243;243m[38;2;235;235;235m▄[48;2;76;76;76m[38;2;199;199;199m▄[48;2;253;253;253m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;202;202;202m[38;2;210;210;210m▄[48;2;7;7;7m[38;2;6;6;6m▄[m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▀[48;2;147;147;147m[38;2;26;26;26m▄[48;2;255;255;255m[38;2;239;239;239m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;86;86;86m[38;2;160;160;160m▄[48;2;177;177;177m[38;2;108;108;108m▄[48;2;25;25;25m[38;2;223;223;223m▄[48;2;111;111;111m[38;2;162;162;162m▄[48;2;159;159;159m[38;2;128;128;128m▄[48;2;227;227;227m[38;2;40;40;40m▄[48;2;254;254;254m[38;2;168;168;168m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;170;170;170m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;142;142;142m[38;2;45;45;45m▄[48;2;7;7;7m[38;2;7;7;7m▄[m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;8;8;8m▀[48;2;106;106;106m[38;2;3;3;3m▄[48;2;254;254;254m[38;2;202;202;202m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;71;71;71m[38;2;45;45;45m▄[48;2;92;92;92m[38;2;115;115;115m▄[48;2;173;173;173m[38;2;88;88;88m▄[48;2;17;17;17m[38;2;15;15;15m▄[48;2;76;76;76m[38;2;200;200;200m▄[48;2;35;35;35m[38;2;237;237;237m▄[48;2;146;146;146m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;203;203;203m[38;2;255;255;255m▄[48;2;153;153;153m[38;2;229;229;229m▄[48;2;239;239;239m[38;2;108;108;108m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;253;253;253m▄[48;2;193;193;193m[38;2;53;53;53m▄[48;2;6;6;6m[38;2;8;8;8m▄[m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;8;8;8m▀[48;2;28;28;28m[38;2;9;9;9m▄[48;2;229;229;229m[38;2;60;60;60m▄[48;2;255;255;255m[38;2;248;248;248m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;254;254;254m[38;2;255;255;255m▄[48;2;36;36;36m[38;2;147;147;147m▄[48;2;101;101;101m[38;2;109;109;109m▄[48;2;10;10;10m[38;2;227;227;227m▄[48;2;4;4;4m[38;2;177;177;177m▄[48;2;238;238;238m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;178;178;178m[38;2;254;254;254m▄[48;2;198;198;198m[38;2;254;254;254m▄[48;2;254;254;254m[38;2;151;151;151m▄[48;2;138;138;138m[38;2;3;3;3m▄[0;38;2;5;5;5m▀[m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;6;6;6m▀[48;2;99;99;99m[38;2;4;4;4m▄[48;2;254;254;254m[38;2;120;120;120m▄[48;2;255;255;255m[38;2;251;251;251m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;240;240;240m▄[48;2;254;254;254m[38;2;30;30;30m▄[48;2;254;254;254m[38;2;19;19;19m▄[48;2;212;212;212m[38;2;1;1;1m▄[48;2;82;82;82m[38;2;7;7;7m▄[0;38;2;2;2;2m▀[0;38;2;7;7;7m▀[m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;5;5;5m▀[48;2;54;54;54m[38;2;9;9;9m▄[48;2;225;225;225m[38;2;5;5;5m▄[48;2;255;255;255m[38;2;90;90;90m▄[48;2;255;255;255m[38;2;224;224;224m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;255;255;255m▄[48;2;255;255;255m[38;2;254;254;254m▄[48;2;255;255;255m[38;2;247;247;247m▄[48;2;255;255;255m[38;2;180;180;180m▄[48;2;254;254;254m[38;2;63;63;63m▄[48;2;185;185;185m[38;2;5;5;5m▄[48;2;45;45;45m[38;2;6;6;6m▄[48;2;220;220;220m[38;2;140;140;140m▄[48;2;89;89;89m[38;2;147;147;147m▄[48;2;10;10;10m[38;2;5;5;5m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▀[0;38;2;1;1;1m▀[48;2;30;30;30m[38;2;7;7;7m▄[48;2;80;80;80m[38;2;7;7;7m▄[48;2;97;97;97m[38;2;6;6;6m▄[48;2;97;97;97m[38;2;89;89;89m▄[48;2;97;97;97m[38;2;13;13;13m▄[48;2;97;97;97m[38;2;8;8;8m▄[48;2;79;79;79m[38;2;7;7;7m▄[48;2;45;45;45m[38;2;7;7;7m▄[0;38;2;13;13;13m▀[0;38;2;5;5;5m▀[48;2;8;8;8m[38;2;6;6;6m▄[0;38;2;8;8;8m▄[48;2;8;8;8m[38;2;13;13;13m▄[48;2;83;83;83m[38;2;11;11;11m▄[48;2;193;193;193m[38;2;239;239;239m▄[48;2;7;7;7m[38;2;12;12;12m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [48;2;7;7;7m[38;2;7;7;7m▄[48;2;201;201;201m[38;2;231;231;231m▄[48;2;5;5;5m[38;2;16;16;16m▄[m [m [m [m [48;2;7;7;7m[38;2;6;6;6m▄[48;2;51;51;51m[38;2;11;11;11m▄[48;2;88;88;88m[38;2;159;159;159m▄[48;2;30;30;30m[38;2;254;254;254m▄[48;2;0;0;0m[38;2;210;210;210m▄[48;2;187;187;187m[38;2;247;247;247m▄[48;2;79;79;79m[38;2;145;145;145m▄[48;2;7;7;7m[38;2;7;7;7m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▄[0;38;2;7;7;7m▄[m [m [48;2;6;6;6m[38;2;6;6;6m▄[48;2;242;242;242m[38;2;232;232;232m▄[48;2;33;33;33m[38;2;13;13;13m▄[m [m [m [m [m [m [0;38;2;6;6;6m▀[48;2;49;49;49m[38;2;7;7;7m▄[48;2;161;161;161m[38;2;6;6;6m▄[48;2;237;237;237m[38;2;6;6;6m▄[48;2;201;201;201m[38;2;39;39;39m▄[48;2;7;7;7m[38;2;7;7;7m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [48;2;2;2;2m[38;2;8;8;8m▄[48;2;133;133;133m[38;2;96;96;96m▄[48;2;60;60;60m[38;2;249;249;249m▄[48;2;8;8;8m[38;2;192;192;192m▄[48;2;4;4;4m[38;2;32;32;32m▄[48;2;207;207;207m[38;2;211;211;211m▄[48;2;7;7;7m[38;2;5;5;5m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;7;7;7m▀[48;2;59;59;59m[38;2;7;7;7m▄[48;2;207;207;207m[38;2;5;5;5m▄[48;2;254;254;254m[38;2;55;55;55m▄[48;2;180;180;180m[38;2;51;51;51m▄[48;2;6;6;6m[38;2;7;7;7m▄[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [0;38;2;6;6;6m▀[0;38;2;8;8;8m▀[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m [m
[?25h"
    return 127
}

