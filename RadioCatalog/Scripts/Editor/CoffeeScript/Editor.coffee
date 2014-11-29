# CoffeeScript
class Editor
  init: ->
    canvas = new fabric.Canvas('editor')
    canvas.width = $(window).width()
    canvas.height = $(window).height()
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

editor = new Editor()