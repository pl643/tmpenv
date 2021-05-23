# install latest linux exa musl binary
foreach(`curl -sL https://github.com/ogham/exa/releases/latest`) {
    if (m!"(.+musl.+?)"!) {
        $url=$1;
        # print "$1\n";
    }
}

$tmpenv =  $ENV{'TMPENV'}; 


print "cd $tmpenv/exa\n";
mkdir "$tmpenv/exa";
chdir "$tmpenv/exa";

print "curl -o exa.zip -L https://github.com/$url\n";
`curl -o exa.zip -sL https://github.com/$url`;

print "unzip -fo exa.zip\n";
`unzip -fo exa.zip`;

print "ln -f $tmpenv/exa/bin/exa $tmpenv/bin\n";
`ln -f $tmpenv/exa/bin/exa $tmpenv/bin`;
