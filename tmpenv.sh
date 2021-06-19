# Configures a portable tmux/fish environment in /tmp/.$USER
#   requirement: wget curl git

# T=/tmp/.T U=https://raw.githubusercontent.com/pl643/tmpenv/master/tmpenv.sh
# curl -sLo$T $U || wget -qO$T $U; ls -l $T; sh $T; rm $T

extract_url() {
    url="$@"
    downloader=$(which curl)
    if [ ! -z $downloader ]; then
        cmdline="$downloader -sL $url"
    else
        downloader=$(which wget)
        if [ ! -z $downloder ]; then
            cmdline="$download -qO- $url"
        else
            echo ERROR: curl/wget not detected
            exit 1
        fi
    fi
    if echo $url | grep zip; then
        cmdline="$cmdline | busybox unzip -q -"
    fi
    if echo $url | grep tgz; then
        cmdline="$cmdline | tar xfz -"
    fi
    # echo "$cmdline"
    eval $cmdline
}

# extract_url
# exit
set -e
alias ta="tmux -2 attach"

export ARCH=$(uname -m)
export TMPENV="/tmp/.$(whoami)"
export HOME=$TMPENV
export DF=$TMPENV/tmpenv
export PATH=$TMPENV/bin:$PATH
export LD_LIBRARY_PATH="$TMPENV/bin"

[ -x $TMPENV/bin/tmux ] && tmux -2 attach 2> /dev/null && exit

[ ! -d $TMPENV ] && mkdir $TMPENV
cd $TMPENV

### Debugging
#BINPATH=$TMPENV/bin-ubuntu1604-$ARCH/usr/local/bin
#tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
#exit

if grep -q Alpine /etc/os-release; then
	echo Alpine Linux $ARCH detected
	# DISTRO="bin-alpine-$ARCH"
	# BINPATH=$TMPENV/$DISTRO/usr/local/bin
	apk add git tmux fish bash neovim
	# if [ ! -d $BINPATH ] ; then
	# 	echo git clone https://github.com/pl643/$DISTRO
	# 	git clone https://github.com/pl643/$DISTRO
	# 	if [ -d $TMPENV/$DISTRO/usr/local/bin/ ] ; then
	# 		ln -sf $TMPENV/$DISTRO/usr/local/bin $TMPENV/bin
	# 	fi
	# fi
	if [ ! -d $DF ] ; then
		git clone https://pl643@github.com/pl643/tmpenv
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi

if grep -q CentOS-7 /etc/os-release; then
	echo Centos-7 $ARCH detected
	DISTRO="bin-centos7-$ARCH"
	BINPATH=$TMPENV/$DISTRO/usr/local/bin
    if test -f /.dockerenv && ! test -f /usr/bin/git; then
        yum -y install git
    fi
	if [ ! -d $BINPATH ] ; then
		echo git clone https://github.com/pl643/$DISTRO
		git clone https://github.com/pl643/$DISTRO
		if [ -d $TMPENV/$DISTRO/usr/local/bin/ ] ; then
			ln -sf $TMPENV/$DISTRO/usr/local/bin $TMPENV/bin
		fi
	fi
	if [ ! -d $DF ] ; then
		git clone https://pl643@github.com/pl643/tmpenv
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi

if grep -q CentOS-8 /etc/os-release; then
	echo Centos-8 $ARCH detected
	DISTRO="bin-centos8-$ARCH"
	BINPATH=$TMPENV/$DISTRO/usr/local/bin
    if test -f /.dockerenv && ! test -f /usr/bin/git; then
        yum -y install git
    fi
	if [ ! -d $BINPATH ] ; then
		echo git clone https://github.com/pl643/$DISTRO
		git clone https://github.com/pl643/$DISTRO
		if [ -d $TMPENV/$DISTRO/usr/local/bin/ ] ; then
			ln -sf $TMPENV/$DISTRO/usr/local/bin $TMPENV/bin
		fi
	fi
	if [ ! -d $DF ] ; then
		git clone https://pl643@github.com/pl643/tmpenv
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi

if grep -q 16.04    /etc/os-release; then
	echo Ubuntu 16.04 $ARCH detected
	BINPATH=$TMPENV/bin-ubuntu1604-$ARCH/usr/local/bin
    if test -f /.dockerenv && ! test -f /usr/bin/git; then
        apt update
        apt install -y git curl
    fi
	if [ ! -d $BINPATH ] ; then
		echo git clone https://github.com/pl643/bin-ubuntu2004-$ARCH
		git clone https://github.com/pl643/bin-ubuntu1604-$ARCH
		if [ -d $TMPENV/bin-ubuntu1604-$ARCH/usr/local/bin/ ] ; then
			ln -sf $TMPENV/bin-ubuntu1604-$ARCH/usr/local/bin $TMPENV/bin
		fi
	fi
	if [ ! -d $DF ] ; then
		git clone https://pl643@github.com/pl643/tmpenv
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi

if grep -q 18.04    /etc/os-release; then
	echo Ubuntu 18.04 $ARCH detected
	BINPATH=$TMPENV/bin-ubuntu1804-$ARCH/usr/local/bin
    if test -f /.dockerenv && ! test -f /usr/bin/git; then
        apt update
        apt install -y git curl
    fi
	if [ ! -d $BINPATH ] ; then
		echo git clone https://github.com/pl643/bin-ubuntu1804-$ARCH
		git clone https://github.com/pl643/bin-ubuntu1804-$ARCH
		if [ -d $TMPENV/bin-ubuntu1804-$ARCH/usr/local/bin/ ] ; then
			ln -sf $TMPENV/bin-ubuntu1804-$ARCH/usr/local/bin $TMPENV/bin
		fi
	fi
	if [ ! -d $DF ] ; then
		git clone https://pl643@github.com/pl643/tmpenv
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi

if grep -q 20.04    /etc/os-release; then
	echo Ubuntu 20.04 $ARCH detected
    if test -f /.dockerenv && ! test -f /usr/bin/git; then
        apt update
        apt install -y git curl
    fi
	if [ ! -d "$TMPENV/bin" ] ; then
        if which git > /dev/null; then
            git clone https://pl643@github.com/pl643/bin-ubuntu2004-$ARCH
            ln -sf "$TMPENV/bin-ubuntu2004-$ARCH/usr/local/bin" $TMPENV/bin
        else
            extract_url https://github.com/pl643/bin-ubuntu2004-x86_64/archive/refs/heads/master.zip
			ln -sf "$TMPENV/bin-ubuntu2004-$ARCH-master/usr/local/bin" $TMPENV/bin
            chmod +x $TMPENV/bin/*
		fi
	fi
	if [ ! -d $DF ] ; then
        if which git > /dev/null; then
            git clone https://pl643@github.com/pl643/tmpenv
        else
            extract_url https://github.com/pl643/tmpenv/archive/refs/heads/master.zip
            mv tmpenv.master tmpenv
        fi
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi

if grep -q buster   /etc/os-release; then
	echo Raspbian 10 $ARCH detected
	ARCH=armv7l
    if test -f /.dockerenv && ! test -f /usr/bin/git; then
        apt update
        apt install -y git curl
    fi
	if [ ! -d "$TMPENV/bin" ] ; then
        if which git > /dev/null; then
            git clone https://pl643@github.com/pl643/bin-raspbian10-$ARCH
            ln -sf "$TMPENV/bin-raspbian10-$ARCH/usr/local/bin" $TMPENV/bin
        else
            # extract_url https://github.com/pl643/bin-ubuntu2004-x86_64/archive/refs/heads/master.zip
	    #		ln -sf "$TMPENV/bin-ubuntu2004-$ARCH-master/usr/local/bin" $TMPENV/bin
            #    chmod +x $TMPENV/bin/*
		fi
	fi
	if [ ! -d $DF ] ; then
        if which git > /dev/null; then
            git clone https://pl643@github.com/pl643/tmpenv
        else
            extract_url https://github.com/pl643/tmpenv/archive/refs/heads/master.zip
            mv tmpenv.master tmpenv
        fi
	fi
	tmux -f $DF/tmux.conf -2 new fish -C "source $DF/fishrc"
fi
