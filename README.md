raspgram-telegram
=================

Install this: https://github.com/vysheng/tg
and compile it in a folder of your choice (e.g. /www/raspgram/shared/tg/) 
	cd /www/raspgram/shared/
	git clone --recursive https://github.com/vysheng/tg.git && cd tg
	./configure [--disable-python --disable-json]
	make

[TODO: list of other requirements and libraries]

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