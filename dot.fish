#!/usr/bin/fish
set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config
set -l dot_dir $HOME/.dotfiles

if test -z "$argv[1]"
    for target in $XDG_CONFIG_HOME $dot_dir
        stow -d $dot_dir/hosts common -t $target
        stow -d $dot_dir/hosts (uname -n) -t $target
    end

else if test "$argv[1]" = edit
    set -q EDITOR; and $EDITOR $dot_dir; or nvim $dot_dir
end
