import QtQuick 2.12
import QtGraphicalEffects 1.0

Flipable {
    id: root

    property alias frontSource: frontImage.imageSource
    property alias backSource: backImage.imageSource
    property bool isFlipped: false

    front: CardItem {
        id: frontImage
        width: root.width
        height: root.height
    }
    back: CardItem {
        id: backImage
        width: root.width
        height: root.height
    }

    state: "front"

    MouseArea { anchors.fill: parent; onClicked: flipped() }

    transform: Rotation {
        id: rotation; origin.x: root.width / 2; origin.y: root.height / 2
        axis.x: 0; axis.y: 1; axis.z: 0
    }

    states: State {
        name: "back"; when: root.isFlipped
        PropertyChanges { target: rotation; angle: 180 }
    }

    transitions: Transition {
        ParallelAnimation {
            NumberAnimation { target: rotation; properties: "angle"; duration: 600 }
            SequentialAnimation {
                NumberAnimation { target: root; property: "scale"; to: 0.75; duration: 300 }
                NumberAnimation { target: root; property: "scale"; to: 1.0; duration: 300 }
            }
        }
    }

    function flipped() {
        root.isFlipped = !root.isFlipped;
    }
}
