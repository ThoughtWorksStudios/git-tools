# git bash completion
if which brew > /dev/null 2>&1; then
  # HomeBrew puts bash completion here
  . /usr/local/etc/bash_completion.d/git-completion.bash
elif [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
else
  echo "Cannot find git bash completion script. Please install them manually or with HomeBrew"
fi

# allow us to type 'g' for git and still have git autocompletion
alias g='git'
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null || complete -o default -o nospace -F _git g

function if_declared {
  local name=$1
  eval "test -z \"\${$name:+''}\"" && return 1
  return 0
}

# define constants only once
if_declared _reset || readonly _reset="\e[0m"
if_declared _red   || readonly _red="\e[0;31m"
if_declared _green || readonly _green="\e[0;32m"

function has_changes {
  local status=$(git status --porcelain 2>/dev/null | grep -vE '^\?\? ')
  if [ -n "$status" ]; then
    echo -n $_red
  else
    echo -n $_green
  fi
}

function git_user_name {
  local author=$(git config --get user.name)
  if [ -z "$author" ]; then
    echo -n "${_red}user.name IS UNSET${_reset}"
  else
    echo -n $author
  fi
}

# metaprogramming, like ruby's alias_method, could be useful
alias_function() {
  local old_name=$(declare -f $1)
  local new_name="$2${old_name#$1}"
  eval "$new_name"
}

PS1='\h:\W $(__git_ps1 "(%s, $(git_user_name)) ")\$ '
