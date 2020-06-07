import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

ColumnLayout {

    Item {
        id: name
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        Image {
            id: image
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:///images/help.png"
            smooth: true
            visible: false
        }
        OpacityMask {
            anchors.fill: image
            source: image
            maskSource: Rectangle {
                width: image.width
                height: image.height
                radius: 8
                visible: false
            }
            layer.enabled: true
            layer.effect: DropShadow {
                samples: 25
            }
        }
    }

    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true
        height: 200
    }

}
