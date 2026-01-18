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
        currentIndex: model.lastIndex
        textRole: "name"
        onActivated: { username.text = currentText }

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

        background: Rectangle { color: "#33333380"; radius: 5 }
      }

      TextField {
        id: username
        anchors.fill: parent
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        text: Platform.userName
        placeholderText: "Username"
        font.bold: true
        color: "white"
        background: Rectangle { color: "#00000000"; border.color: "transparent"; radius: 5 }
        selectByMouse: true
      }
    }

    Item {
      id: passwordField
      width: parent.width
      height: 50

      Button {
        id: passwordIcon
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 40
        height: 40
        icon.source: "Assets/Password2.svg"
        onClicked: password.echoMode = password.echoMode === TextInput.Password ? TextInput.Normal : TextInput.Password
        background: Rectangle { color: "transparent" }
      }

      TextField {
        id: password
        anchors.left: passwordIcon.right
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        horizontalAlignment: TextInput.AlignHCenter
        placeholderText: "Password"
        echoMode: TextInput.Password
        color: "white"
        background: Rectangle { color: "#00000000"; border.color: "transparent"; radius: 5 }
      }
    }

    Button {
      id: loginButton
      width: parent.width
      text: "Login"
    }
  }
}
