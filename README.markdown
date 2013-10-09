# MGD - Minimal Git Deploy

MGD is an ultra-simple git deployable system.

While there are plenty of other *better* git deployment solutions out there
(seriously, just search github for "git-deploy" if you want something that
doesn't completely suck), sometimes you just want something quick and dirty.

Enter MGD, a git deployment system intentionally acronymed after a certain
brand of beer. It's quick, it's dirty, it'll get the job done, but it's not
exactly something you want to tell anyone about

## Installing MGD on Server

On your server:
```bash
git clone git://github.com/choptastic/mgd
cd mgd
sudo make install
```

## Setting up a repository

On your server:
```bash
mgd git://github.com/yourname/projectname.git
```

* The app itself will be placed into apps/projectname
* The bare git repo will be placed into git/projectname.git

If you need some extra scripts (like enabling hot code reloading in Erlang, or
if you use something *less enlightened*, you can restart the server or whatever
you need to do), then just edit the contents of
`git/projectname.git/hooks/post-receive`.


## On your workstation

You don't need to think too hard about this one, since the above step tells you
almost exactly what to do when the installation process completes.

```bash
git remote add live <username>@<servername>/path/to/git
git push live master
```

## That's it

Yep, it doesn't do anything else. It just sets up the server to receive deployments and push them.

## About

Questions? Post an issue.

Author: [Jesse Gumm](http://jessegumm.com) ([@jessegumm](http://twitter.com/jessegumm))

License: MIT LICENSE
