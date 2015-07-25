raspgram-telegram
=================

Install this: https://github.com/vysheng/tg

[TODO: list of requirements and libraries]

To manual launch the server, use:
screen -dm -S tgram [path of the telegram-cli lib relative to app] -s ./queue.lua -k [path to the default public key]"

To see the status (and send other commands), use:
screen -r tgram -p 0 -X stuff "[your command]] $(printf \\\r)"