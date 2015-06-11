GhostTyper = require './ghost-typer'
{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    console.log 'ok'
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'ghost-typer:start': => @start()
      'ghost-typer:pause': => @pause()
      'ghost-typer:stop': => @stop()

  deactivate: ->
    @subscriptions.dispose()

  start: ->
    return @typer.resume() if @typer?.isStarted()

    console.log 'GhostTyper was started!'
    pane = atom.workspace.getActivePane()
    items = pane.getItems()
    sourceEditor = items[0]
    editor = pane.getActiveItem()
    return if items.length < 2 or editor is sourceEditor

    console.log GhostTyper
    @typer = new GhostTyper(sourceEditor, editor)
    @typer.start()

  pause: ->
    @typer?.pause()

  stop: ->
    @typer?.stop()
    @typer.destroy()
    @typer = null
