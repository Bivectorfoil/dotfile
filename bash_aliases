# more safely way to delet files
alias rm='move(){ /bin/mv -v $@ ~/Trash ;};move $@'
# alias vim='nvim'
