function sort-tmux-windows
    while not perl $DF/scripts/tmux-sort-windows.pl; end
end

if test -n "$argv"
    $argv
end
