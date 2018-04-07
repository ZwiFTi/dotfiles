# Automatically add completion for all aliases to commands having completion functions
function alias_completion {
    local namespace="alias_completion"

    # parse function based completion definitions, where capture group 2 => function and 3 => trigger
    local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
    # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

    # create array of function completion triggers, keeping multi-word triggers together
    eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
    (( ${#completions[@]} == 0 )) && return 0

    # create temporary file for wrapper functions and completions
    rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
    local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1

    local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"

    # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
    local line; while read line; do
        eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
        local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

        # skip aliases to pipes, boolean control structures and other command lists
        # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
        eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
        # avoid expanding wildcards
        read -a alias_arg_words <<< "$alias_args"

        # skip alias if there is no completion function triggered by the aliased command
        if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
            if [[ -n "$completion_loader" ]]; then
                # force loading of completions for the aliased command
                eval "$completion_loader $alias_cmd"
                # 124 means completion loader was successful
                [[ $? -eq 124 ]] || continue
                completions+=($alias_cmd)
            else
                continue
            fi
        fi
        local new_completion="$(complete -p "$alias_cmd")"

        # create a wrapper inserting the alias arguments if any
        if [[ -n $alias_args ]]; then
            local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
            # avoid recursive call loops by ignoring our own functions
            if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
                local compl_wrapper="_${namespace}::${alias_name}"
                    echo "function $compl_wrapper {
                        (( COMP_CWORD += ${#alias_arg_words[@]} ))
                        COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                        (( COMP_POINT -= \${#COMP_LINE} ))
                        COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                        (( COMP_POINT += \${#COMP_LINE} ))
                        $compl_func
                    }" >> "$tmp_file"
                    new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
            fi
        fi

        # replace completion trigger by alias
        new_completion="${new_completion% *} $alias_name"
        echo "$new_completion" >> "$tmp_file"
    done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    source "$tmp_file" && rm -f "$tmp_file"
}; alias_completion

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Function to cd into dir with ls
d() { cd "$@" && ls -G; }

# Function for git
# clone my <project>
cm() { git clone https://github.com/ZwiFTi/"$@".git; }

# Financial functions
ks() { python ~/dotfiles/projects/financials/cashflowstatement.py "$@"; }
alias mc='python ~/dotfiles/projects/financials/marketcap.py'

# Aliases
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
alias ls='ls -G'
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"
alias dot="cd ~/dotfiles"

# Get week number
alias week='date +%V'

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Determine size of a file or total size of a directory
fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    # shellcheck disable=SC2199
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg -- .[^.]* *
    fi
}

# Git pull/push easymode
alias pull="git pull origin master"
alias pus="git push origin master"
push() {
    git add .
    git commit -m "$@"
    git push origin master;
}

function testingargs {
    echo "My arguments are: "$@""
}




# Fast programming information

## JavaScript
alias javascript.function.syntax='p ~/dotfiles/hotkeys/javascript/javascript.function.syntax'
alias javascript.function.syntax.edit='vim ~/dotfiles/hotkeys/javascript/javascript.function.syntax'
alias javascript.function.syntax.open='open https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions'

alias javascript.class.syntax='p ~/dotfiles/hotkeys/javascript/javascript.class.syntax'
alias javascript.class.syntax.edit='vim ~/dotfiles/hotkeys/javascript/javascript.class.syntax'
alias javascript.class.syntax.open='open https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/classes'


## Tmux
alias tmux.hk='p ~/dotfiles/hotkeys/tmux.hk'
alias tmux.hk.edit='vim ~/dotfiles/hotkeys/tmux.hk'

## Terminal
alias terminal.hk='p ~/dotfiles/hotkeys/terminal/terminal.hk'
alias terminal.hk.edit='vim ~/dotfiles/hotkeys/terminal/terminal.hk'

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircinstall.sholors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
