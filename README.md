### Compiling
```
coffee -cwj ./js/main.js ./coffee/main.coffee  ./coffee/helpers.coffee  ./coffee/snakes.coffee  ./coffee/food.coffee
```

### To do

* Collision death, game-over and restart
* Better food generation algorithm (nothing near center or main snake head)
* Shares
* Touch events
* Avoid hacky turn back (pressing two arrows almost instantaneously)