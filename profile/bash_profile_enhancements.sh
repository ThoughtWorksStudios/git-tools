# git bash completion
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
      . /usr/local/git/contrib/completion/git-completion.bash
fi

bash_boost=$HOME/git-tools/profile/bash_boost
. $bash_boost/bash_colors.sh
. $bash_boost/bash_vcs.sh
. $bash_boost/profile_prompt.sh
