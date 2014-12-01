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
          image.setCoords(100,100);
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

  addBinding: ->
    editor.binding = true

  addObjBinding: (obj1, obj2) ->
    if (obj1.bindCount == undefined)
      obj1.bindCount = 1
    if (obj1.bindedObj == undefined)
      obj1.bindedObj = new fabric.group(obj2)
    if (obj1.bindedObj != undefined)
      flag = false
      for element in obj1.bindedObj
        if (element == obj2)
          flag = true
      if (flag == false)
        obj1.bindedObj.add(obj2)

  createLines: ->
    

  init: ->
    canvas = new fabric.Canvas('editor', 
      selection: false)
    canvas.width = $(window).width()
    canvas.height = $(window).height()
    canvas.forEachObject( (obj) ->
      obj.on('selected', () ->
        console.log("test")
        if (editor.binding == true)
          if (editor.groupObj == undefined)
            editor.groupObj = new fabric.group(obj)
          if (editor.groupObj.count == 2)
            addObjBinding(editor.groupObj[0], editor.groupObj[1])
      )
      for element in obj1.bindedObj
        @createLines()
    )
    @addImageLoadEvent(canvas)

editor = new Editor()