import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Rectangle {
    readonly property int cardWidth: 218
    readonly property int cardHeight: 340
    property alias image: image_

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredWidth: cardWidth
    Layout.preferredHeight: cardHeight
    color: "transparent"

    signal cardClicked()

    Image {
        id: image_
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
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
