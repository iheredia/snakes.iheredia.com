# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

gridWidth = 100
gridHeight = 50

atFrameRate = (frameRate) ->
  {
    do: (action) ->
      setInterval(action, 1000/frameRate)
  }

_currentColor = -1

nextColor = ->
  colors = [
    '#ff0000',
    '#00ff00',
    '#0000ff'
  ]
  _currentColor += 1
  colors[_currentColor]

randomPosition = ->
  {
    x: Math.round(Math.random()*gridWidth),
    y: Math.round(Math.random()*gridHeight)
  }

areAtSamePlace = (oneThing, otherThing) ->
  oneThing.position.x == otherThing.position.x && oneThing.position.y == otherThing.position.y

drawingCanvas = {
  $el: null
  el: null
  ctx: null

  init: ->
    @$el = $('canvas')
    @el = @$el[0]
    @el.width = @$el.width()
    @el.height = @$el.height()
    @ctx = @el.getContext('2d')

  clear: ->
    @ctx.clearRect(0, 0, @el.width, @el.height)

  drawSquare: (x, y, color) ->
    @ctx.fillStyle = color
    @ctx.fillRect(
      x*@el.width/gridWidth,
      y*@el.height/gridHeight,
      @el.width/gridWidth,
      @el.height/gridHeight
    )

}

bindEvents = (snake) ->
  changeDirection = (e) ->
    if e.keyCode == 37 and snake.direction != 'right'
      snake.direction = 'left'
    else if e.keyCode == 38 and snake.direction != 'down'
      snake.direction = 'up'
    else if e.keyCode == 39 and snake.direction != 'left'
      snake.direction = 'right'
    else if e.keyCode == 40 and snake.direction != 'up'
      snake.direction = 'down'
  $(window).on('keydown', changeDirection)