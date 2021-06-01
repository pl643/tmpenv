# toggle alt status in tmux status to turn off alt-hjkl for nested tmux sessions

function toggle_alt_status
    set -x ALTSTAT (tmux showenv TMUX_ALT_HJKL|cut -f2 -d=)
    if test $ALTSTAT -eq 0    # currently off run on script
       tmux bind-key -n M-h select-pane -L \; bind-key -n  M-j select-pane -D \; bind-key -n M-k select-pane -U \; bind-key -n  M-k send-keys Up \; bind-key -n  M-j send-keys Down \; \
            bind-key -n  M-l select-pane -R \; set -g prefix C-a \; bind-key -n M-o next-window \; bind-key -n  M-i previous-window \; \
        set-option -g status-right "ALT #[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "
        tmux setenv TMUX_ALT_HJKL 1
    else 
        tmux unbind -n M-h \; unbind -n M-j \; unbind -n M-k \; unbind -n M-l \; set -g prefix C-b \; unbind-key -n M-o \; unbind-key -n M-i \; unbind-key -n M-u \; \
        set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "
        tmux setenv TMUX_ALT_HJKL 0
    end
end

toggle_alt_status
