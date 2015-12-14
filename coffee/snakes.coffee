class Snake
  length: 6

  startDying: ->
    @status = 'dying'
    @swapColor = @color
    @color = 'rgba(0,0,0,0)'
    @blinkCounter = 0
    @blinkInterval = setInterval(=>
      @blinkCounter += 1
      [@swapColor, @color] = [@color, @swapColor]
      if @blinkCounter > 8
        clearInterval(@blinkInterval)
        @status = 'dead'
    , 250)

class MainSnake extends Snake

  constructor: ->
    @status = 'dead'
    @color = '#ededed'
    @direction = 'right'
    @drawingCanvas = new DrawingCanvas($('canvas'))
    @position = {
      x: Math.round(@drawingCanvas.gridWidth/2),
      y: Math.round(@drawingCanvas.gridHeight/2)
    }
    @history = [ { x: @position.x, y: @position.y } ]

  move: ->
    if @direction == 'right'
     @position.x += 1
    else if @direction == 'left'
      @position.x -= 1
    else if @direction == 'up'
      @position.y -= 1
    else
      @position.y += 1
    @position.x = @drawingCanvas.normalizeWidth(@position.x)
    @position.y = @drawingCanvas.normalizeHeight(@position.y)

    @history.push { x: @position.x, y: @position.y }

  render: ->
    for i in [1..6]
      if @history.length-i > -1
        @drawingCanvas.drawSquare(@history[@history.length-i].x, @history[@history.length-i].y, @color)
      else
        @drawingCanvas.drawSquare(@history[0].x + @history.length-i, @history[0].y, @color)

  occupiedSpace: ->
    @history.slice(@history.length-6, @history.length)

  keyPressed: (keyCode) ->
    if keyCode == 37 and @direction != 'right'
      @direction = 'left'
    else if keyCode == 38 and @direction != 'down'
      @direction = 'up'
    else if keyCode == 39 and @direction != 'left'
      @direction = 'right'
    else if keyCode == 40 and @direction != 'up'
      @direction = 'down'

  isEating: (anotherSnake) ->
    anotherSnakeBody = anotherSnake.occupiedSpace()
    for position in anotherSnakeBody
      if @position.x == position.x and @position.y == position.y
        return true
    false

class MirrorSnake extends Snake

  constructor: (@params)->
    @color = @params.color
    @originalSnake = @params.of
    @offset = 0
    @drawingCanvas = new DrawingCanvas($('canvas'))
    @shiftPoint = shiftPositionFarFrom(@originalSnake)

  move: ->
    @offset += 1

  render: ->
    for position in @occupiedSpace()
      @drawingCanvas.drawSquare(position.x, position.y, @color)

  occupiedSpace: ->
    originalPositions = @originalSnake.history.slice(@offset, @offset+@length)
    shiftedPositions = []
    for position in originalPositions
      shiftedPositions.push({
        x: @drawingCanvas.normalizeWidth(position.x + @shiftPoint.x)
        y: @drawingCanvas.normalizeHeight(position.y + @shiftPoint.y)
      })
    shiftedPositions

  isEating: (anotherSnake) ->
    anotherSnakeBody = anotherSnake.occupiedSpace()
    [..., myPosition] = @occupiedSpace()
    for position in anotherSnakeBody
      if myPosition.x == position.x and myPosition.y == position.y
        return true
    false
