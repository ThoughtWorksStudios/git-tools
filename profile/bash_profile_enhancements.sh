# git bash completion
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

readonly _reset=$(tput sgr0)
readonly _red=$(tput setaf 1)
readonly _green=$(tput setaf 2)

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

PS1='\h:\W $(__git_ps1 "($(has_changes)%s, $(git_user_name)$_reset) ")\$ '
