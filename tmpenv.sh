# configure a portable tmux/fish environment without installing packages

set -e

export ARCH=$(uname -m)
export TMPENV="/tmp/.$(whoami)"
export DF=$TMPENV/tmpenv
export PATH=$TMPENV/bin:$PATH

[ -x $TMPENV/bin/tmux ] && tmux -2 attach && exit

[ ! -d $TMPENV ] && mkdir $TMPENV
cd $TMPENV

#if grep -q CentOS-7 /etc/os-release; then
#fi
#if grep -q CentOS-8 /etc/os-release; then
#fi
#if grep -q 18.04    /etc/os-release; then
#fi
if grep -q 20.04    /etc/os-release; then
	echo Ubuntu 2004 $ARCH detected
	BINPATH=$TMPENV/bin-ubuntu2004-$ARCH/usr/local/bin
	if [ ! -d $BINPATH ] ; then
		echo git clone https://github.com/pl643/bin-ubuntu2004-$ARCH
		git clone https://github.com/pl643/bin-ubuntu2004-$ARCH
		if [ -d $TMPENV/bin-ubuntu2004-$ARCH/usr/local/bin/ ] ; then
			ln -sf $TMPENV/bin-ubuntu2004-$ARCH/usr/local/bin $TMPENV/bin
		fi
	fi
	if [ ! -d $DF ] ; then
		git clone https://pl643:Kao95843@github.com/pl643/tmpenv
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi
