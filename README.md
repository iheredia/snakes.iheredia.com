# Snakes

Game made with `coffeescript` over `<canvas>`.

Changes to the code can be made to the files in the `coffee` dir and then compiled to javascript calling the next command over the console `coffee -cj ./js/main.js ./coffee/*`

The only third party libraries being used are FontAwesome and jQuery, for icons and dom manipulation. As they are served through a cdn, local instances of the game must be running on a local http server. Python's SimppleHttpServer seems to be one of the easiest choices, just run `python -m SimpleHTTPServer 8080` and the go to [http://localhost:8080/](http://localhost:8080/)

## To do list
* Avoid hacky turnback (pressing two arrows almost instantaneously)
* Levels
* Touch events
* Social sharing