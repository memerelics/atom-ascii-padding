AsciiPadding = require './ascii-padding'
# jp

module.exports =
  activate: -> AsciiPadding._activate()
  deactivate: -> AsciiPadding._deactivate()
  pad: -> AsciiPadding._pad()

  config:
    autoPaddingAfterSave:
      type: 'boolean'
      default: true
    ignorePaddingWords:
      description: 'These non-ascii words ignored.'
      type: 'array'
      default: ['、', '。','，','．', '「', '」','『','』', '【', '】']
      items:
        type: 'string'
