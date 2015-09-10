# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

$ ->
  drawingCanvas.init()

  mainSnake = new MainSnake
  mirrorSnakes = []
  food = new Food

  bindEvents(mainSnake)

  mainLoop = ->
    drawingCanvas.clear()

    mainSnake.move()

    food.render()

    if areAtSamePlace(mainSnake, food)
      mirrorSnakes.push new MirrorSnake(of: mainSnake, color: food.color)
      food.regenerate()

    for snake in mirrorSnakes
      snake.move()
      snake.render()

      if collision(mainSnake, snake)
        # TODO colission
        console.log 'dead'

    mainSnake.render()

  atFrameRate(20).do(mainLoop)