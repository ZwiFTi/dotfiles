
# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

alias c='clear'
alias p='pygmentize -g'
alias ll='ls -la'
alias cl='curl -L'
alias ..='cd ..'
alias ...='cd ...'
alias now='date +"%T"'
alias sl='ls'
alias hk='cat ~/hotkey'
alias hkedit='touch ~/hotkey; atom ~/hotkey'
alias bashedit='touch ~/.bash_profile; atom ~/.bash_profile'





# Fast programming information

## JavaScript
alias javascript.function.syntax='p ~/bp/javascript.function.syntax'
alias javascript.function.syntax.edit='atom ~/bp/javascript.function.syntax'
alias javascript.function.syntax.open='open https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions'

alias javascript.class.syntax='p ~/bp/javascript.class.syntax'
alias javascript.class.syntax.edit='atom ~/bp/javascript.class.syntax'
alias javascript.class.syntax.open='open https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/classes'


## Tmux

alias tmux.hk='p ~/tmux.hk'
alias tmux.hk.edit='vim ~/tmux.hk'


#Udacity GIT profile
# Enable tab completion
source ~/dotfiles/git-completion.bash

# Change command prompt
source ~/dotfiles/git-prompt.sh

# colors!
red="\[\033[38;5;203m\]"
green="\[\033[38;05;38m\]"
blue="\[\033[0;34m\]"
reset="\[\033[0m\]"

export GIT_PS1_SHOWDIRTYSTATE=1

# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$red\u$green\$(__git_ps1)$blue \W
$ $reset"
