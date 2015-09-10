# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

class MainSnake
  length: 6

  constructor: ->
    @position = { x: Math.round(gridWidth/2), y: Math.round(gridHeight/2) }
    @history = [ { x: @position.x, y: @position.y } ]
    @color = '#ededed'
    @direction = 'right'

  move: ->
    if @direction == 'right'
     @position.x += 1
     if @position.x >= gridWidth
       @position.x = 0
    else if @direction == 'left'
      @position.x -= 1
      if @position.x < 0
        @position.x = gridWidth - 1
    else if @direction == 'up'
      @position.y -= 1
      if @position.y < 0
        @position.y = gridHeight - 1
    else
      @position.y += 1
      if @position.y >= gridHeight
        @position.y = 0

    @history.push { x: @position.x, y: @position.y }

  render: ->
    for i in [1..6]
      if @history.length-i > -1
        drawingCanvas.drawSquare(@history[@history.length-i].x, @history[@history.length-i].y, @color)
      else
        drawingCanvas.drawSquare(@history[0].x + @history.length-i, @history[0].y, @color)

class MirrorSnake
  constructor: (@params)->
    @color = @params.color
    @originalSnake = @params.of
    @offset = 0

  move: ->
    @offset += 1

  render: ->
    for i in [0...6]
      position = @originalSnake.history[@offset+i]
      drawingCanvas.drawSquare(position.x, position.y, @color)