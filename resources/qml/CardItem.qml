import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias imageSource: image.source

    signal cardClicked()

    Image {
        id: image
        fillMode: Image.PreserveAspectFit
        visible: false
    }
    OpacityMask {
        anchors.fill: root
        source: image
        maskSource: Rectangle {
            width: root.width
            height: root.height
            radius: 8
            visible: false
        }
        layer.enabled: true
        layer.effect: DropShadow {
            samples: 25
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: cardClicked()
    }
}
