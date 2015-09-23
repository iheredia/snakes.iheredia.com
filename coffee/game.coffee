class Game

  constructor: ->
    @initGame()
    @initCanvas()
    @bindEvents()
    @startMainLoop()

  initGame: ->
    @mainSnake = new MainSnake
    @mirrorSnakes = []
    @dyingSnakes = []
    @foods = [new Food]
    @score = 0

  initCanvas: ->
    @gridWidth = 100
    @gridHeight = 50
    @drawingCanvas = new DrawingCanvas($('canvas'))

  bindEvents: ->
    $(window).on('keydown', (e) =>
      if e.keyCode == 37 or e.keyCode == 38 or e.keyCode == 39 or e.keyCode == 40
        if @mainSnake.status == 'dead'
          @initGame()
          @mainSnake.status = 'alive'
        @mainSnake.keyPressed(e.keyCode)
    )

  startMainLoop: ->
    @frameRate = 20
    setInterval(@mainLoop, 1000/@frameRate)

  addScore: ->
    @score += 1
    $('#score-number').text(@score)

  resetScore: ->
    @score = 0
    $('#score-number').text(@score)

  mainLoop: =>
    if @mainSnake.status == 'alive'
      @moveSnakes()
      @checkFood()
      @lookForCollisions()
      @collectDying()
      @removeDead()
    @renderAll()

  moveSnakes: ->
    @mainSnake.move()
    for mirrorSnake in @mirrorSnakes
      mirrorSnake.move()

  checkFood: ->
    for food in @foods
      if @mainSnake.isEating(food)
        @addSnakeFrom(food)
        @addScore()
      for snake in @mirrorSnakes
        if snake.isEating(food)
          @addSnakeFrom(food)

  addSnakeFrom: (food)->
    @mirrorSnakes.push new MirrorSnake(of: @mainSnake, color: food.color)
    food.regenerateDependingOn(@mainSnake.position)

  renderAll: ->
    @drawingCanvas.clear()
    for mirrorSnake in @mirrorSnakes
      mirrorSnake.render()
    for dyingSnake in @dyingSnakes
      dyingSnake.render()
    if @mainSnake.status == 'alive'
      for food in @foods
        food.render()
    @mainSnake.render()

  lookForCollisions: ->
    allSnakes = [@mainSnake].concat(@mirrorSnakes)
    for firstSnake in allSnakes
      for secondSnake in allSnakes
        if firstSnake != secondSnake and firstSnake.isEating(secondSnake)
          secondSnake.startDying()

  collectDying: ->
    aliveSnakes = []
    for mirrorSnake in @mirrorSnakes
      if mirrorSnake.status == 'dying'
        @dyingSnakes.push(mirrorSnake)
      else
        aliveSnakes.push(mirrorSnake)
    @mirrorSnakes = aliveSnakes

  removeDead: ->
    filteredDyingSnakes = []
    for snake in @dyingSnakes
      if snake.status == 'dying'
        filteredDyingSnakes.push(snake)
    @dyingSnakes = filteredDyingSnakes