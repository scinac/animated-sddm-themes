import QtQuick 2.15

QtObject {
  id: config

  property string backgroundVideo: ""
  property string backgroundImage: ""
  property bool pauseBackground: false
  property bool cropBackground: true
  property real backgroundSpeed: 1.0

  property string clockText: "white"
  property string dateText: "#cccccc"
  property string formBackground: "#00000030"
  property string dimBackground: "#00000040"

  property string formPosition: "center"
  property bool fullBlur: true
  property bool partialBlur: false
  property real blur: 2.0
  property int blurMax: 32

  function loadConf(path) {
    var xhr = new XMLHttpRequest()
    xhr.open("GET", path, false)
    xhr.onreadystatechange = function() {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          var lines = xhr.responseText.split("\n")
          for (var i=0; i<lines.length; i++) {
            var line = lines[i].trim()
            if (line === "" || line.startsWith("#") || line.startsWith("[")) continue
            var parts = line.split("=")
            if (parts.length !== 2) continue
            var key = parts[0].trim()
            var value = parts[1].trim()

            switch(key) {
              case "video": backgroundVideo = value; break
              case "image": backgroundImage = value; break
              case "pause": pauseBackground = (value === "true"); break
              case "crop": cropBackground = (value === "true"); break
              case "speed": backgroundSpeed = parseFloat(value); break

              case "clockText": clockText = value; break
              case "dateText": dateText = value; break
              case "formBackground": formBackground = value; break
              case "dimBackground": dimBackground = value; break

              case "formPosition": formPosition = value; break
              case "fullBlur": fullBlur = (value === "true"); break
              case "partialBlur": partialBlur = (value === "true"); break
              case "blur": blur = parseFloat(value); break
              case "blurMax": blurMax = parseInt(value); break

              default: console.log("Unknown config key:", key); break
            }
          }
        } else {
          console.log("Failed to load config:", xhr.status)
        }
      }
    }
    xhr.send()
  }
}
