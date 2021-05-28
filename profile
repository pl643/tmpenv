# below is for sourcing after ~/.profile to auto-resume tmux
# [ -f /tmp/.$USER/tmpenv/profile ] && source /tmp/.$USER/tmpenv/profile

export USER=$(whoami)
export TMPENV="/tmp/.$USER"
export DF="$TMPENV/tmpenv"

if [ -d "$TMPENV/bin" ] ; then
    export PATH="$TMPENV/bin:$PATH"
fi

if [ -f "$DF/fishrc" ]; then
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi
