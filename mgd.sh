#!/bin/sh

APPNAME=`basename $1 .git`
ROOT=`pwd`
APP=$ROOT/apps/$APPNAME
GIT=$ROOT/git/$APPNAME.git
TMP=$ROOT/apps/$APPNAME.temp

if [ $# -ne 1 ]; then
	echo "Usage: `basename $0` {git repository}";
	exit 1
fi

if [ -e $APP ]; then
	echo "Error: $APP already exists. Aborting"
	exit 1
else
	mkdir -p $TMP
	mkdir -p $APP
	mkdir -p $GIT
	cd $GIT
	git init --bare
	printf "#!/bin/sh\nGIT_WORK_TREE=$APP git checkout -f" > hooks/post-receive
	chmod +x hooks/post-receive
	cd $TMP
	git init
	git remote add origin $1
	git remote add live $GIT
	git pull origin master
	git push live +master:refs/heads/master
	rm -fr $TMP

	echo ""
	echo "********************************"
	echo "Created $APP from $1"
	echo "Two more steps on your workstation:"
	echo "1) git remote add live `whoami`@<SERVERNAME>:$GIT"
	echo "2) git push live master"
	echo "********************************"
fi
