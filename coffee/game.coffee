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
    @food = new Food
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
      @renderAll()
      @lookForCollisions()
      @removeDying()
    @mainSnake.render()

  moveSnakes: ->
    @mainSnake.move()
    for mirrorSnake in @mirrorSnakes
      mirrorSnake.move()

  checkFood: ->
    if @mainSnake.isEating(@food)
      @mirrorSnakes.push new MirrorSnake(of: @mainSnake, color: @food.color)
      @food.regenerateDependingOn(@mainSnake.position)
      @addScore()

  renderAll: ->
    @drawingCanvas.clear()
    for mirrorSnake in @mirrorSnakes
      mirrorSnake.render()
    for dyingSnake in @dyingSnakes
      dyingSnake.render()
    @food.render()

  lookForCollisions: ->
    allSnakes = [@mainSnake].concat(@mirrorSnakes)
    for firstSnake in allSnakes
      for secondSnake in allSnakes
        if firstSnake != secondSnake and firstSnake.isEating(secondSnake)
          secondSnake.status = 'dying'

  removeDying: ->
    aliveSnakes = []
    for mirrorSnake in @mirrorSnakes
      if mirrorSnake.status == 'dying'
        @dyingSnakes.push(mirrorSnake)
      else
        aliveSnakes.push(mirrorSnake)
    @mirrorSnakes = aliveSnakes

  showGameOver: ->
    $('#game-over').show()

  hideGameOver: ->
    $('#game-over').hide()

  collision: (oneSnake, anotherSnake) ->
    intersect(oneSnake.occupiedSpace(), anotherSnake.occupiedSpace())
