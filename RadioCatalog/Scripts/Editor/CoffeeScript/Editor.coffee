# CoffeeScript
class Editor
  addImageLoadEvent: (canvas) ->
    handleImage = (e) ->
      reader = new FileReader()
      reader.onload = (event) ->
        img = new Image()
        img.src = event.target.result
        img.onload = ->
          image = new fabric.Image(img)
          image.set({
            angle: 0,
            padding: 10,
            cornersize:10,
          })
          canvas.centerObject(image);
          canvas.add(image);
          canvas.renderAll();
      reader.readAsDataURL e.target.files[0]
    imageLoader = document.getElementById("uploadImg")
    imageLoader.addEventListener "change", handleImage, false
    ctx = canvas.getContext("2d")

  addWireDrawing: ->
    editor.wireDrawing = true

  makeLine: (coords) ->
    new fabric.Line(coords,  
      fill: 'black'
      stroke: 'black'
      strokeWidth: 2
      selectable: false
    )

  init: ->
    canvas = new fabric.Canvas('editor', 
      selection: false)
    canvas.width = $(window).width()
    canvas.height = $(window).height()
    canvas.on('mouse:up', (options) ->
      if (editor.wireDrawing == true)
        pointer = canvas.getPointer(options.e)
        if ((editor.prevX != undefined) && (editor.prevY != undefined)) 
          diffX = Math.abs(editor.prevX - pointer.x)
          diffY = Math.abs(editor.prevY - pointer.y)
          if (diffX < diffY)
            line = editor.makeLine([editor.prevX, editor.prevY, editor.prevX, pointer.y])
            editor.prevY = pointer.y
          if (diffX >= diffY)
            line = editor.makeLine([editor.prevX, editor.prevY, pointer.x, editor.prevY])
            editor.prevX = pointer.x
          canvas.add(line)
          canvas.renderAll()
        if ((editor.prevX == undefined) && (editor.prevY == undefined)) 
          editor.prevX = pointer.x
          editor.prevY = pointer.y
    )    
    @addImageLoadEvent(canvas)

editor = new Editor()