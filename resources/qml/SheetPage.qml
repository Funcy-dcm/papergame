import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item {
    property var ratio: imageSheet.paintedWidth/imageSheet.sourceSize.width

    Item {
        id: imageItem
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        Image {
            id: imageSheet
            anchors.fill: parent

            fillMode: Image.PreserveAspectFit
            source: "qrc:///images/sheet.png";
            layer.enabled: true
            layer.effect: DropShadow {
                samples: 25
            }
        }

        Rectangle {
            id: mainRectangle
            anchors.centerIn: parent
            width: imageSheet.paintedWidth
            height: imageSheet.paintedHeight
            border.color: "red"
            border.width: 1
//            color: "white"
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("sheet")
                }

                Rectangle {
                    id: nameRectangle
                    property alias text: nameText.text
                    x: 37*ratio
                    y: 173*ratio
                    width: 199*ratio
                    height: 56*ratio
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Text {
                        id: nameText
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        property var pixelSize: 18
                        font.pixelSize: pixelSize * ratio
                        text: "Name"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("mouse: 0" + nameText.pixelSize)
                            nameDialog.open();
                        }
                    }
                }

                Item {
                    property alias text: homeText1.text
                    x: 260*ratio
                    y: 111*ratio
                    width: 54*ratio
                    height: 92*ratio

                    Rectangle {
                        id: homeRect1
                        anchors.fill: parent
                        border.color: "#ff8c00"
                        border.width: 2
                        radius: 4
                        color: "#10ff8c00"
                        visible: false
                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            verticalOffset: 1
                            color: "#80000000"
                            samples: 25
                            spread: 0.2
                        }
                    }

                    SpinBox {
                        id: homeSpinBox1
                         value: 5
                         from: 0
                         to: 15
                         Material.foreground: "white"
                         visible: homeRect1.visible
                         background: Rectangle {
                             color: "#444444"
                             opacity: 0.9
                             implicitWidth: 140
                             radius: 4
                         }
                         anchors.top: homeRect1.bottom
                         anchors.horizontalCenter: homeRect1.horizontalCenter
                     }

                    Text {
                        id: homeText1
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        layer.enabled: false
                        property var pixelSize: 18
                        font.pixelSize: pixelSize * ratio
                        text: "15"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            homeRect1.visible = !homeRect1.visible;
                            console.log("home: "+ homeText1.text);
                        }
                    }
                }

                Rectangle {
                    id: quarterRect01
                    x: 252*ratio
                    y: 88*ratio
                    width: 72*ratio
                    height: 19*ratio
                    border.color: "red"
                    border.width: 1
                    radius: 0
                    color: "transparent"
                    Rectangle {
                        id: quarterRect1
                        anchors.fill: parent
                        anchors.topMargin: 5*ratio
                        anchors.bottomMargin: 5*ratio
                        color: "black"
                        radius: 2
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("quarter: 1")
                            quarterRect1.visible = !quarterRect1.visible;
                        }
                    }
                }
                Rectangle {
                    x: 324*ratio
                    y: 88*ratio
                    width: 72*ratio
                    height: 19*ratio
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: quarterRect2
                        anchors.fill: parent
                        anchors.topMargin: 5*ratio
                        anchors.bottomMargin: 5*ratio
                        color: "black"
                        radius: 2
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("quarter: 1")
                            quarterRect2.visible = !quarterRect2.visible;
                        }
                    }
                }

                Rectangle {
                    x: 314*ratio
                    y: 80*ratio
                    width: 19*ratio
                    height: 134*ratio
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect1
                        anchors.fill: parent
                        anchors.margins: 5*ratio
                        color: "black"
                        radius: 2
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("fence: 1");
                            fenceRect1.visible = !fenceRect1.visible;
                        }
                    }
                }
                Rectangle {
                    x: (314+73*1)*ratio
                    y: 80*ratio
                    width: 19*ratio
                    height: 134*ratio
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect2
                        anchors.fill: parent
                        anchors.margins: 5*ratio
                        color: "black"
                        radius: 2
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("fence: 2")
                            fenceRect2.visible = !fenceRect2.visible;
                        }
                    }
                }
                Rectangle {
                    x: (314+73*2)*ratio
                    y: 80*ratio
                    width: 19*ratio
                    height: 134*ratio
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect3
                        anchors.fill: parent
                        anchors.margins: 5*ratio
                        color: "black"
                        radius: 2
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("fence: 3")
                            fenceRect3.visible = !fenceRect3.visible;
                        }
                    }
                }
                Rectangle {
                    x: (314+73*3)*ratio
                    y: 80*ratio
                    width: 19*ratio
                    height: 134*ratio
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect4
                        anchors.fill: parent
                        anchors.margins: 5*ratio
                        color: "black"
                        radius: 2
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("fence: 4")
                            fenceRect4.visible = !fenceRect4.visible;
                        }
                    }
                }
            }
        }
    }

    NameDialog {
        id: nameDialog
        onAccepted: nameRectangle.text = nameDialog.text
    }
}
