{CompositeDisposable} = require 'atom'

module.exports =
  AsciiPadding =
    _activate: (state) ->
      @subscriptions = new CompositeDisposable
      @subscriptions.add atom.commands.add 'atom-workspace', 'ascii-padding:pad': => @_pad()

    _deactivate: ->
      @subscriptions.dispose()

    _pad: ->
      if editor = atom.workspace.getActiveTextEditor()
        buffer = editor.getBuffer()
        buffer.transact ->
          japanese = "\\u0020-\\u007E"
          # TODO: 例外をユーザ定義可能にする
          # buffer.scan /(\w+)([^\u0020-\u007E])/g,   ({l, match, replace}) ->   replace("#{match[1]} #{match[2]}")
          # TODO: 改行は許す
          buffer.scan new RegExp("(\\w+)([^#{japanese}])", 'g'),   ({l, match, replace}) ->   replace("#{match[1]} #{match[2]}")
          buffer.scan new RegExp("([^\\n#{japanese}])(\\w+)", 'g'), ({l, match, replace}) ->   replace("#{match[1]} #{match[2]}")
