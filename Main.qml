import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Effects
import QtMultimedia 6.5

import "utils"

Pane {
  width: 800
  height: 450

  Config {
    id: config
  }

  Component.onCompleted: {
    config.loadConf("/usr/share/sddm/themes/animated-sddm-themes/themeConfigs/makima.conf")
    if (config.backgroundVideo !== "") {
        bgplayer.source = Qt.resolvedUrl(config.backgroundVideo)
        bgplayer.play()
      }
    Qt.callLater(function () {
      password.forceActiveFocus()
    })
  }

  Item {
    id: backgroundContainer
    anchors.fill: parent

    MediaPlayer {
      id: bgplayer
      autoPlay: true
      videoOutput: videoOutput
      loops: MediaPlayer.Infinite
      onPlayingChanged: backgroundPlaceholderImage.visible = false
      //source: Qt.resolvedUrl("./backgrounds/senjougahara1920x1080.mp4")
      source: Qt.resolvedUrl(config.backgroundVideo)
    }

    VideoOutput {
      id: videoOutput
      anchors.fill: parent
      fillMode: VideoOutput.PreserveAspectCrop
    }

    Image {
      id: backgroundPlaceholderImage
      anchors.fill: parent
      visible: true
      //source: "./backgrounds/senjougahara1920x1080.png"
      source: config.backgroundImage
    }

    MouseArea {
      anchors.fill: parent
      onClicked: parent.forceActiveFocus()
    }
  }

  ShaderEffectSource {
    id: blurMask
    height: parent.height
    width: parent.width * 0.4
    anchors.left: parent.left
    anchors.top: parent.top

    sourceItem: backgroundContainer
    sourceRect: Qt.rect(0, 0, width, height)

    wrapMode: ShaderEffectSource.ClampToEdge
    smooth: true
  }

  MultiEffect {
    anchors.fill: blurMask
    source: blurMask
    blurEnabled: true
    //blur: 0.9
    blur: config.blur
    //blurMax: 32
    blurMax: config.blurMax
  }

  Column {
    id: clockContainer
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 150
    anchors.leftMargin: 220
    spacing: 4

    Text {
      id: clock
      text: Qt.formatTime(new Date(), "hh:mm AP")
      font.pixelSize: 86
      font.bold: true
      //color: "white"
      color: config.clockText
      horizontalAlignment: Text.AlignHCenter
    }

    Text {
      id: date
      text: Qt.formatDate(new Date(), "dddd, MMMM d")
      font.pixelSize: 36
      //color: "#cccccc"
      color: config.dateText
      horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
      anchors.fill: clockContainer
      //color: "#00000040"
      color: config.dimBackground
      radius: 12
      z: -1
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: {
        clock.text = Qt.formatTime(new Date(), "hh:mm AP")
        date.text = Qt.formatDate(new Date(), "dddd, MMMM d")
      }
    }
  }
  
  Column {
    id: form
    spacing: 20
    width: blurMask.width * 0.8
    anchors.centerIn: blurMask

    Rectangle {
      anchors.fill: parent
      //color: "#00000030"
      color: config.formBackground
      radius: 10
    }

    Item {
      id: usernameField
      width: parent.width
      height: 50

      ComboBox {
        id: selectUser
        width: parent.width
        height: parent.height
        model: userModel
        currentIndex: userModel.lastIndex
        textRole: "name"
        contentItem: Item {}
        onActivated: { 
          username.text = currentText
          password.forceActiveFocus()
        }

        delegate: ItemDelegate {
          width: parent.width
          contentItem: Text {
            text: model.name
            font.pixelSize: 16
            //color: "white"
            color: config.formText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }
          background: Rectangle { color: selectUser.highlightedIndex === index ? "#55555580" : "transparent" }
        }

        background: Rectangle { 
          color: "#33333380";
          radius: 65
        }
      }

      Image {
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.verticalCenter: parent.verticalCenter
        width: 20
        height: 20
        source: "./assets/account-login.svg"
        opacity: 0.7
      }

      TextField {
        id: username
        anchors.fill: parent
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        text: selectUser.currentText
        placeholderText: "Username"
        font.bold: true
        //color: "white"
        color: config.formText
        background: Rectangle {
          color: config.formFieldBackground; 
          border.color: "transparent";
          radius: 65 
        }
        selectByMouse: true
      }
    }

    Item {
      id: passwordField
      width: parent.width
      height: 50

      Image {
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.verticalCenter: parent.verticalCenter
        width: 20
        height: 20
        source: "./assets/passwordKey.svg"
        opacity: 0.7
      }

      TextField {
        id: password
        height: parent.height
        anchors.fill: parent
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        placeholderText: "Password"
        echoMode: TextInput.Password
        //color: "white"
        color: config.formText
        background: Rectangle { 
          color: config.formFieldBackground;
          //color: "#33333380";
          border.color: "transparent";
          radius: 20 
        }

        Keys.onReturnPressed: {
          let sessionIndex = sessionModel.lastIndex
          if (sessionIndex < 0) sessionIndex = 0
          sddm.login(username.text, password.text, sessionIndex)
        }
      }
    }
  }

  Connections {
    target: sddm

    function onLoginFailed() {
      password.text = ""
      password.forceActiveFocus()
    }
  }
}
