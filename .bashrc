alias k="kubectl"
alias ll="ls -lsa"

check_status() {

red="$bold$(tput setaf 1)"
green=$(tput setaf 2)

boshka= git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' > /dev/null 2>&1

# Checks if something to commit or not
if git rev-parse --git-dir > /dev/null 2>&1; then
    if ! git status | grep "nothing to commit" > /dev/null 2>&1; then
      echo "${red} x "
      return 0
    elif $boshka; then
        echo "${green} ✔ "
    fi
fi

}

# Git branch

check_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# **********In-line style interface**********
if whoami | grep -q "+"
then
  current_user=$(whoami | cut -d'+' -f 2)
else
  current_user=$(whoami)
fi

export PS1=" \[\e[0m\]\[\$(check_status)\]"
       PS1+="\[\e[0;35m\]\$current_user \[$(tput sgr0)\]"
       PS1+="\[$(tput sgr0)\]\[\e[1;34m\]\$PWD\[\e[0m\]"
       PS1+="\[\e[0;36m\]\$(check_branch)\[\e[0m\] \[$(tput sgr0)\]"
       PS1+="\[\e[0;33m\] ➜ \[\e[0m\]"


export CLICOLOR=1
export LSCOLORS=fxfxBxDxgxegedabagacad
