function sort-tmux-windows
    set active_pane (tmux list-panes | grep active | cut -d " " -f 7)
    while not perl $DF/scripts/tmux-sort-windows.pl; end
    set old_active_window (tmux list-panes -a | grep $active_pane | cut -c 3)
    tmux select-window -t $old_active_window
end

if test -n "$argv"
    $argv
end

