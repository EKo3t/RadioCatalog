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
          editor.AddSelectEventForObject(image)
          editor.AddMoveEventForObject(image)
          if (image.type == undefined)
            image.type = "image"
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

  addBinding: ->
    editor.binding = true

  AddObjBinding: (obj1, obj2) ->
    if (obj1.bindedObj == undefined)
      obj1.bindedObj = new fabric.Group()
      obj1.bindedObj.add(obj2)
    if (obj1.bindedObj != undefined)
      flag = false
      for element in obj1.bindedObj
        if (element == obj2)
          flag = true
      if (flag == false)
        obj1.bindedObj.add(obj2)

  CreateGroupOfLines: (point1, point2) ->
    group = new fabric.Group()
    
    line = editor.makeLine([point1.x, point1.y, point2.x, point1.y])
    group.add(line)
    line = editor.makeLine([point2.x, point1.y, point2.x, point2.y])
    group.add(line)
    group

  CreateLines: (obj1, obj2) ->
    obj1.middlePoint = new Array(obj1.mt, obj1.ml, obj1.mr, obj1.mb)
    obj2.middlePoint = new Array(obj2.mt, obj2.ml, obj2.mr, obj2.mb)
    min = Infinity
    for element1 in obj1.middlePoint
      for element2 in obj2.middlePoint
        dist = Math.pow(element1.x - element2.x, 2) + Math.pow(element1.y - element2.y, 2)
        if dist < min
          min = dist
          minElement1 = element1
          minElement2 = element2
    if ((minElement1 != undefined) && (minElement2 != undefined))
      group = editor.CreateGroupOfLines(minElement1, minElement2)
      

  AddSelectEventForObject: (obj) ->
    obj.on('selected', () ->
      if (editor.binding == true)
        if (editor.groupObj != undefined)
          editor.groupObj.add(obj)
          editor.AddObjBinding(editor.groupObj.item(0), editor.groupObj.item(1))
          editor.lineGroup = new fabric.Group()
          editor.lineGroup.add(editor.CreateLines(editor.groupObj.item(0).oCoords, editor.groupObj.item(1).oCoords))
          editor.lineGroup.name = "lines"
          editor.lineGroup.selectable = false
          editor.canvas.add(editor.lineGroup)
          editor.canvas.renderAll()
          editr.groupObj = undefined
        if (editor.groupObj == undefined)
          editor.groupObj = new fabric.Group()
          editor.groupObj.add(obj)
    )

  AddMoveEventForObject: (obj) ->
    obj.on('move', () -> 
      for element in editor.canvas
        
    )
      

  init: ->
    @canvas = new fabric.Canvas('editor', 
      selection: false)
    @canvas.width = $(window).width()
    @canvas.height = $(window).height()
    @addImageLoadEvent(@canvas)

editor = new Editor()