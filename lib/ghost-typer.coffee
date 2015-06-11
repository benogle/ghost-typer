module.exports =
class GhostTyper
  constructor: (@sourceEditor, @editor) ->
    @charsBeforePause = 20
    @largeDelay = 100
    @delay = 20
    @index = 0
    @counter = 0
    @text = @sourceEditor.getText()

  isStarted: -> @isRunning

  start: ->
    @isRunning = true
    @run()

  pause: ->
    clearTimeout(@timeout)

  resume: ->
    @run()

  stop: ->
    @pause()
    @index = 0
    @isRunning = false

  destroy: ->
    @stop()
    @text = null
    @sourceEditor = null
    @editor = null

  run: ->
    pause = if @largePause
      (Math.random() * 100 + @largeDelay)
    else
      (Math.random() * 50 + @delay)

    @timeout = setTimeout =>
      @insertCurrentChar()
      @counter++
      if @counter is (@nextPause ? @charsBeforePause)
        @nextPause = parseInt(@charsBeforePause + Math.random() * 5)
        @largePause = true
        @counter = 0
      else
        @largePause = false
      @run()
    , pause

  insertCurrentChar: =>
    @editor.insertText(@text[@index])
    @index++
