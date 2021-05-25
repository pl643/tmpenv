# sort tmux windows
# returns 1 if window swap occurs

$line=1;

foreach(`tmux list-windows | sort -k2 `) {
    if(/(\d+):/) {
        $cwin=$1;
        if($cwin != $line) { 
            `tmux swap-window -s $cwin -t $line`;
            print "swapping windows $cwin $line: tmux swap-window -s $cwin -t $line\n";
            exit 1;
        } 
    }
    $line++;
}
