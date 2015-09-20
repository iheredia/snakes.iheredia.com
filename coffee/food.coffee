# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

class Food

  constructor: ->
    @color = nextColor()
    @drawingCanvas = new DrawingCanvas($('canvas'))
    @position = randomPosition(@drawingCanvas.gridWidth, @drawingCanvas.gridHeight)

  render: ->
    @position.x = @drawingCanvas.normalizeWidth(@position.x)
    @position.y = @drawingCanvas.normalizeHeight(@position.y)
    @drawingCanvas.drawSquare(@position.x, @position.y, @color)

  regenerateDependingOn: (snakePosition) ->
    while @distanceToCenter() < 10 or @distanceToSnake(snakePosition) < 10
      @position = randomPosition(@drawingCanvas.gridWidth, @drawingCanvas.gridHeight)
    @color = nextColor()

  distanceToCenter: ->
    distance(@position, {x:@drawingCanvas.gridWidth/2, y:@drawingCanvas.gridHeight/2})

  distanceToSnake: (snakePosition) ->
    distance(@position, snakePosition)

  occupiedSpace: ->
    [@position]