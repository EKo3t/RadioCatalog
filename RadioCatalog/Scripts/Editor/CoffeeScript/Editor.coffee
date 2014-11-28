# CoffeeScript
class Editor
  init: (width, height) ->
    canvas = new fabric.Canvas('editor')
    canvas.width = width - 100
    canvas.height = height - 100
    return undefined

editor = new Editor()