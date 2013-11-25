#!/bin/sh

APPNAME=`basename $1 .git`
ROOT=`pwd`
APPROOT=$ROOT/apps
APP=$APPROOT/$APPNAME
GITROOT=$ROOT/git
GIT=$GITROOT/$APPNAME.git
TMP=$ROOT/$APPNAME.temp

if [ $# -ne 1 ]; then
	echo "Usage: `basename $0` {git repository}";
	exit 1
fi

if [ -e $APP ]; then
	echo "Error: $APP already exists. Aborting"
	exit 1
else
	mkdir -p "$APPROOT"
	mkdir -p "$GITROOT"

	## Initialize the bare directory from the source
	cd "$GITROOT"
	git clone --bare "$1"

	## Add the post hook to deploy
	cd "$GIT"
	printf "#!/bin/sh\nunset GIT_DIR\n(cd $APP;git pull)" > hooks/post-receive
	chmod +x hooks/post-receive

	## Clone the full repo from the newly created local bare repo
	cd "$APPROOT"
	git clone "$GIT"

	echo ""
	echo "********************************"
	echo "Created $APP from $1"
	echo "Two more steps on your workstation:"
	echo "1) git remote add live `whoami`@<SERVERNAME>:$GIT"
	echo "2) git push live master"
	echo "********************************"
fi
