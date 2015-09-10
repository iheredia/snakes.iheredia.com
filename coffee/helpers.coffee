# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

_playing = false
playing = -> _playing
setPlaying = (boolean) -> _playing = boolean

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
    '#bc2424',
    '#2abc24',
    '#2461bc',
    '#6c24bc',
    '#b6bc24',
    '#24bca3',
    '#0e2ba6',
    '#a60e93'
  ]
  _currentColor = (_currentColor + 1) % colors.length
  colors[_currentColor]

randomPosition = ->
  {
    x: Math.round(Math.random()*gridWidth),
    y: Math.round(Math.random()*gridHeight)
  }

areAtSamePlace = (oneThing, otherThing) ->
  oneThing.position.x == otherThing.position.x && oneThing.position.y == otherThing.position.y

collision = (oneSnake, anotherSnake) ->
  false

drawingCanvas = {
  $el: null
  el: null
  ctx: null

  init: ->
    @$el = $('canvas')
    @el = @$el[0]
    @el.width = @$el.width()
    @el.height = @$el.height()
    minGridSize = 50
    if @el.height < @el.width
      gridHeight = minGridSize
      gridWidth = Math.round(minGridSize*@el.width/@el.height)
    else
      gridHeight = Math.round(minGridSize*@el.height/@el.width)
      gridWidth = minGridSize

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
    if playing()
      if e.keyCode == 37 and snake.direction != 'right'
        snake.direction = 'left'
      else if e.keyCode == 38 and snake.direction != 'down'
        snake.direction = 'up'
      else if e.keyCode == 39 and snake.direction != 'left'
        snake.direction = 'right'
      else if e.keyCode == 40 and snake.direction != 'up'
        snake.direction = 'down'
    else if e.keyCode == 37 or e.keyCode == 38 or e.keyCode == 39 or e.keyCode == 40
      hideGameOver()
      setPlaying(true)

  $(window).on('keydown', changeDirection)

showGameOver = ->
  $('#game-over').show()

hideGameOver = ->
  $('#game-over').hide()