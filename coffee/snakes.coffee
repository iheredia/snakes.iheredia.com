# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

class MainSnake
  length: 6

  constructor: ->
    @position = { x: Math.round(gridWidth/2), y: Math.round(gridHeight/2) }
    @history = []
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
    if @history.length < 6
      for position in @history
        drawingCanvas.drawSquare(position.x, position.y, @color)
    else
      for i in [1...6]
        drawingCanvas.drawSquare(@history[@history.length-i].x, @history[@history.length-i].y, @color)

class MirrorSnake
  constructor: (@params)->
    @color = @params.color
    @originalSnake = @params.of
    @offset = 0

  move: ->
    @offset += 1

  render: ->
    for i in [0..6]
      position = @originalSnake.history[@offset+i]
      drawingCanvas.drawSquare(position.x, position.y, @color)