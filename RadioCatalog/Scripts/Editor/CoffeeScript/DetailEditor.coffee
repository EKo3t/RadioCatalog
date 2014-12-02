# CoffeeScript
class DetailEditor
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

  init: ->
    @canvas = new fabric.Canvas('detailLoad', selection: false)
    @addImageLoadEvent(@canvas)
    ctx = @canvas.getContext("2d")
    
detailEditor = new DetailEditor()