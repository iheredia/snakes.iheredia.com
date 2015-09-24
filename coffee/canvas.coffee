class DrawingCanvas

  constructor: (@$el) ->
    @el = @$el[0]
    $(window).resize(@setSizes)
    @setSizes()
    @ctx = @el.getContext('2d')

  setSizes: =>
    @el.width = @$el.width() if @el.width != @$el.width()
    @el.height = @$el.height() if @el.height != @$el.height()
    @minGridSize = 50

    if @el.height < @el.width
      @gridHeight = @minGridSize
      @gridWidth = Math.round(@minGridSize*@el.width/@el.height)
    else
      @gridHeight = Math.round(@minGridSize*@el.height/@el.width)
      @gridWidth = @minGridSize

  clear: ->
    @ctx.clearRect(0, 0, @el.width, @el.height)

  drawSquare: (x, y, color) ->
    @ctx.fillStyle = color
    x = @normalizeWidth(x)
    y = @normalizeHeight(y)
    @ctx.fillRect(
      x*@el.width/@gridWidth,
      y*@el.height/@gridHeight,
      @el.width/@gridWidth,
      @el.height/@gridHeight
    )

  normalizeWidth: (x) ->
    @normalize(x, @gridWidth)

  normalizeHeight: (y) ->
    @normalize(y, @gridHeight)

  normalize: (n, mod)->
    while n < 0
      n += mod
    while n >= mod
      n -= mod
    n