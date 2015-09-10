# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

class Food

  constructor: ->
    @position = randomPosition()
    @color = nextColor()

  render: ->
    drawingCanvas.drawSquare(@position.x, @position.y, @color)

  regenerate: ->
    @position = randomPosition()
    @color = nextColor()