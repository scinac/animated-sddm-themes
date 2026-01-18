import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Effects

Window {
  width: 800
  height: 450
  title: "Login screen"

  Component.onCompleted: {
    Qt.callLater(function () {
      password.forceActiveFocus()
    })
  }

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
    blur: 0.9
    blurMax: 32
  }
  
  Column {
    id: form
    spacing: 20
    width: blurMask.width * 0.8
    anchors.centerIn: blurMask

    Rectangle {
      anchors.fill: parent
      color: "#00000030"
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
        onActivated: { 
          username.text = currentText
          password.forceActiveFocus()
        }

        delegate: ItemDelegate {
          width: parent.width
          contentItem: Text {
            text: model.name
            font.pixelSize: 16
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }
          background: Rectangle { color: selectUser.highlightedIndex === index ? "#55555580" : "transparent" }
        }

        background: Rectangle { color: "#33333380"; radius: 15 }
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
        color: "white"
        background: Rectangle {
          color: "#00000000"; 
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
        color: "white"
        background: Rectangle { 
          color: "#33333380";
          border.color: "transparent";
          radius: 20 
        }

        Keys.onReturnPressed: {
          sddm.login(
            username.text,
            password.text,
            sessionModel.lastIndex
          )
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
