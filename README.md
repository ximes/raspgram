raspgram-telegram
=================

Install this: https://github.com/vysheng/tg
and compile it in a folder of your choice (e.g. /www/raspgram/shared/tg/) 
	cd /www/raspgram/shared/
	git clone --recursive https://github.com/vysheng/tg.git && cd tg
	./configure [--disable-python --disable-json]
	make

Capistrano should take of reloading/connectin the client after deploy. For running the server manually, run:
rake connect
in the app's folder. Or add a startup script like the following:

sudo nano /etc/init.d/raspgram
	### BEGIN INIT INFO
	# Short-Description: Raspgram
	# Description:       Raspgram
	# Provides:          raspgram
	# Required-Start:    $local_fs $network
	# Required-Stop:     $local_fs
	# Default-Start:     2 3 4 5
	# Default-Stop:      0 1 6
	### END INIT INFO

	#! /bin/sh
	case "$1" in
	start)
	    su - deploy -c "cd /srv/raspgram/current && rake connect" >> /var/log/nginx/startup.log 2>&1
	    ;;
	stop)
	    su - deploy -c "screen -X -S tgram quit" >> /var/log/nginx/startup.log 2>&1
	    ;;
	*)
	    echo "usage: $0 (start|stop|restart)"
	;;
	esac

sudo update-rc.d raspgram defaults
To remove it:
sudo update-rc.d -f raspgram remove



sudo chmod 755 /etc/init.d/raspgram

[TODO: list of other requirements and libraries]
 # Be sure to have rake installed for the autoconnection tasks (Sinatra)

To manual launch the server, use:
screen -dm -S tgram [path of the telegram-cli lib relative to app] -s ./queue.lua -k [path to the default public key]"

To see the status (and send other commands), use:
screen -r tgram -p 0 -X stuff "[your command]] $(printf \\\r)"


Libs: 
lua
"socket.http"
"ltn12"
"lyaml" #https://github.com/gvvaughan/lyaml
	sudo luarocks --server=http://rocks.moonscript.org install lyaml
