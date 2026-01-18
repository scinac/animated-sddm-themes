import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Effects

Window {
  width: 800
  height: 450
  title: "Login screen"

  Image {
    id: backgroundImage
    anchors.fill: parent
    source: "./backgrounds/senjougahara1920x1200.png"
    fillMode: Image.PreserveAspectCrop
    smooth: true
  }

  ShaderEffectSource {
    id: blurMask
    height: parent.height
    width: parent.width * 0.4
    anchors.left: parent.left
    anchors.top: parent.top

    sourceItem: backgroundImage
    sourceRect: Qt.rect(0, 0, width, height)

    wrapMode: ShaderEffectSource.ClampToEdge
    smooth: true
  }

  MultiEffect {
    anchors.fill: blurMask
    source: blurMask
    blurEnabled: true
    blur: 0.8
    blurMax: 32
  }
}
