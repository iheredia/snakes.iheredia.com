class Game

  constructor: ->
    @mainSnake = new MainSnake
    @mirrorSnakes = []
    @food = new Food

    @gameState = 'paused'
    @score = 0

    @initCanvas()
    @bindEvents()

    @frameRate = 20
    setInterval(@mainLoop, 1000/@frameRate)

  initCanvas: ->
    @gridWidth = 100
    @gridHeight = 50
    @drawingCanvas = new DrawingCanvas($('canvas'))

  bindEvents: ->
    $(window).on('keydown', (e) =>
      if e.keyCode == 37 or e.keyCode == 38 or e.keyCode == 39 or e.keyCode == 40
        @gameState = 'playing'
        @mainSnake.keyPressed(e.keyCode)
    )

  addScore: ->
    @score += 1
    $('#score-number').text(@score)

  resetScore: ->
    @score = 0
    $('#score-number').text(@score)

  mainLoop: =>
    if @gameState == 'playing'
      @drawingCanvas.clear()
      @mainSnake.move()

      if areAtSamePlace(@mainSnake, @food)
        @mirrorSnakes.push new MirrorSnake(of: @mainSnake, color: @food.color)
        @food.regenerateDependingOn(@mainSnake.position)
        @addScore()

      for @snake in @mirrorSnakes
        @snake.move()
        @snake.render()

        if @collision(@mainSnake, @snake)
          @gameState = 'over'

    @food.render()
    @mainSnake.render()

  showGameOver: ->
    $('#game-over').show()

  hideGameOver: ->
    $('#game-over').hide()

  collision: (oneSnake, anotherSnake) ->
    intersect(oneSnake.occupiedSpace(), anotherSnake.occupiedSpace())
