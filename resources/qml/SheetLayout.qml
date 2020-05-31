import QtQuick 2.12
import QtQuick.Layouts 1.12

ColumnLayout {
    id: root
    anchors.margins: 10

    readonly property int sheetWidth: 1081
    readonly property int sheetHeight: 1081

    Item {
        id: imageItem
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        Image {
            id: imageSheet
            anchors.fill: parent

            fillMode: Image.PreserveAspectFit
            source: "qrc:///images/sheet.png";
        }

        Rectangle {
            id: mainRectangle
            x: (imageSheet.width - imageSheet.paintedWidth)/2
            y: (imageSheet.height - imageSheet.paintedHeight)/2
            width: imageSheet.paintedWidth
            height: imageSheet.paintedHeight
            border.color: "red"
            border.width: 1
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("sheet")
                }

                Rectangle {
                    id: nameRectangle
                    property alias text: nameText.text
                    x: 37*imageSheet.paintedWidth/sheetWidth
                    y: 173*imageSheet.paintedWidth/sheetWidth
                    width: (236-37)*imageSheet.paintedWidth/sheetWidth
                    height: (229-173)*imageSheet.paintedWidth/sheetWidth
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
                        font.pixelSize: pixelSize * imageSheet.paintedWidth/sheetWidth
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

                Rectangle {
                    id: homeRect1
                    property alias text: homeText1.text
                    x: 260*imageSheet.paintedWidth/sheetWidth
                    y: 111*imageSheet.paintedWidth/sheetWidth
                    width: (314-260)*imageSheet.paintedWidth/sheetWidth
                    height: (203-111)*imageSheet.paintedWidth/sheetWidth
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Text {
                        id: homeText1
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        property var pixelSize: 18
                        font.pixelSize: pixelSize * imageSheet.paintedWidth/sheetWidth
                        text: "15"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("home: "+ homeRect1.text)
                            //                            nameDialog.open();
                        }
                    }
                }

                Rectangle {
                    x: 252*imageSheet.paintedWidth/sheetWidth
                    y: 88*imageSheet.paintedWidth/sheetWidth
                    width: 72*imageSheet.paintedWidth/sheetWidth
                    height: 19*imageSheet.paintedWidth/sheetWidth
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: quarterRect1
                        anchors.fill: parent
                        anchors.topMargin: 5*imageSheet.paintedWidth/sheetWidth
                        anchors.bottomMargin: 5*imageSheet.paintedWidth/sheetWidth
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
                    x: 324*imageSheet.paintedWidth/sheetWidth
                    y: 88*imageSheet.paintedWidth/sheetWidth
                    width: 72*imageSheet.paintedWidth/sheetWidth
                    height: 19*imageSheet.paintedWidth/sheetWidth
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: quarterRect2
                        anchors.fill: parent
                        anchors.topMargin: 5*imageSheet.paintedWidth/sheetWidth
                        anchors.bottomMargin: 5*imageSheet.paintedWidth/sheetWidth
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
                    x: 314*imageSheet.paintedWidth/sheetWidth
                    y: 80*imageSheet.paintedWidth/sheetWidth
                    width: 19*imageSheet.paintedWidth/sheetWidth
                    height: 134*imageSheet.paintedWidth/sheetWidth
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect1
                        anchors.fill: parent
                        anchors.margins: 5*imageSheet.paintedWidth/sheetWidth
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
                    x: (314+73*1)*imageSheet.paintedWidth/sheetWidth
                    y: 80*imageSheet.paintedWidth/sheetWidth
                    width: 19*imageSheet.paintedWidth/sheetWidth
                    height: 134*imageSheet.paintedWidth/sheetWidth
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect2
                        anchors.fill: parent
                        anchors.margins: 5*imageSheet.paintedWidth/sheetWidth
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
                    x: (314+73*2)*imageSheet.paintedWidth/sheetWidth
                    y: 80*imageSheet.paintedWidth/sheetWidth
                    width: 19*imageSheet.paintedWidth/sheetWidth
                    height: 134*imageSheet.paintedWidth/sheetWidth
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect3
                        anchors.fill: parent
                        anchors.margins: 5*imageSheet.paintedWidth/sheetWidth
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
                    x: (314+73*3)*imageSheet.paintedWidth/sheetWidth
                    y: 80*imageSheet.paintedWidth/sheetWidth
                    width: 19*imageSheet.paintedWidth/sheetWidth
                    height: 134*imageSheet.paintedWidth/sheetWidth
                    border.color: "red"
                    border.width: 1
                    color: "transparent"
                    Rectangle {
                        id: fenceRect4
                        anchors.fill: parent
                        anchors.margins: 5*imageSheet.paintedWidth/sheetWidth
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
