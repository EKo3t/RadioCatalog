﻿# CoffeeScript
class Editor
  init: ->
    canvas = new fabric.Canvas('editor')
    canvas.width = $(window).width()
    canvas.height = $(window).height()
    return canvas

editor = new Editor()