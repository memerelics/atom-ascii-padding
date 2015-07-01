{CompositeDisposable} = require 'atom'

module.exports =
  AsciiPadding =
    _activate: (state) ->
      @subscriptions = new CompositeDisposable
      @subscriptions.add atom.commands.add 'atom-workspace', 'ascii-padding:pad': => @_pad()

    _deactivate: ->
      @subscriptions.dispose()

    _pad: ->
      return unless editor = atom.workspace.getActiveTextEditor()
      return false if editor.selections[0].getText().length == 0
      editor.replaceSelectedText null, (txt) ->
          ignorePaddingWords = atom.config.get('ascii-padding.ignorePaddingWords') || []
          regexLeft = new RegExp("([^ -~｡-ﾟ\t#{ignorePaddingWords.join('')}])(\\w+)", 'g')
          while leftMatch = regexLeft.exec(txt)
            txt = txt.slice(0, leftMatch.index + 1) + " " + txt.slice(leftMatch.index + 1)
          regexRight = new RegExp("(\\w+)([^ -~｡-ﾟ\t\n#{ignorePaddingWords.join('')}])", 'g')
          while rightMatch = regexRight.exec(txt)
            txt = txt.slice(0, rightMatch.index + rightMatch[1].length) + " " + txt.slice(rightMatch.index + rightMatch[1].length)
          return txt
