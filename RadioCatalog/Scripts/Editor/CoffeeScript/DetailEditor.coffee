# CoffeeScript
class DetailEditor
  AddImageLoadEvent: (canvas) ->
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
            selectable: false
          })
          if (image.width > 100)
            image.width = 100
          if (image.height > 100)
            image.height = 100
          if (image.type == undefined)
            image.type = "image"
          if (canvas.lastObject != undefined)
            canvas.remove(canvas.lastObject)
          image.setCoords(0,0);        
          canvas.add(image);
          canvas.centerObject(image)
          canvas.renderAll();
          canvas.lastObject = image
      reader.readAsDataURL e.target.files[0]
    imageLoader = document.getElementById("uploadImgBtn")
    imageLoader.addEventListener "change", handleImage, false

  AddProperty: ->
    propName = document.getElementById('propertyName').value
    propValue = document.getElementById('propertyValue').value
    if (@canvas.lastObject != undefined)
      if (@canvas.propertyName == undefined)
        @canvas.propertyName = new Array()
        @canvas.propertyValue = new Array()
    flag = false
    for i in [0..@canvas.propertyName.length-1]
      if (@canvas.propertyName == propName)      
        flag = true
    if (flag == false)
      @canvas.propertyName.push(propName)
      @canvas.propertyValue.push(propValue)
    detailEditor.DisplayProperties()

  DisplayProperties: ->
    @propCanvas = new fabric.Canvas('propertyDisplay', selection: false)
    for i in [0..@canvas.propertyName.length-1]
      text = new fabric.Text(@canvas.propertyName[i] + ": " + @canvas.propertyValue[i], 
                             selectable: false, fontSize: 15, fontFamily: 'Ubuntu')
      @propCanvas.add(text)
    @propCanvas.renderAll()

  Init: ->
    @canvas = new fabric.Canvas('detailLoad', selection: false)
    @AddImageLoadEvent(@canvas)
    ctx = @canvas.getContext("2d")
    
detailEditor = new DetailEditor()