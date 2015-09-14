# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

class Food

  constructor: ->
    @position = randomPosition()
    @color = nextColor()

  render: ->
    drawingCanvas.drawSquare(@position.x, @position.y, @color)

  regenerateDependingOn: (snakePosition) ->
    while distance(@position, {x:gridWidth/2, y:gridHeight/2}) < 10 or distance(@position, snakePosition) < 10
      @position = randomPosition()
    @color = nextColor()