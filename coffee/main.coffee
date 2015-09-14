# Ignacio Heredia
# ignacio.nh@gmail.com
# Buenos Aires, Argentina

$ ->
  drawingCanvas.init()

  mainSnake = new MainSnake
  mirrorSnakes = []
  food = new Food
  score = 0

  bindEvents(mainSnake)

  mainLoop = ->
    if playing()

      drawingCanvas.clear()

      mainSnake.move()

      if areAtSamePlace(mainSnake, food)
        mirrorSnakes.push new MirrorSnake(of: mainSnake, color: food.color)
        food.regenerateDependingOn(mainSnake.position)
        score += 1
        $('#score-number').text(score)

      for snake in mirrorSnakes
        snake.move()
        snake.render()

        if collision(mainSnake, snake)
          # TODO
          setPlaying(false)
          showGameOver()

    food.render()
    mainSnake.render()

  atFrameRate(20).do(mainLoop)