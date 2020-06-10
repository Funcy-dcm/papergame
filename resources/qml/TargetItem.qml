import QtQuick 2.12
import QtGraphicalEffects 1.0

Flipable {
    id: container

    property alias frontSource: frontImage.imageSource
    property alias backSource: backImage.imageSource
    property bool isFlipped: false

    front: CardItem {
        id: frontImage
        width: container.width
        height: container.height
    }
    back: CardItem {
        id: backImage
        width: container.width
        height: container.height
    }

    state: "front"

    MouseArea { anchors.fill: parent; onClicked: flipped() }

    transform: Rotation {
        id: rotation; origin.x: container.width / 2; origin.y: container.height / 2
        axis.x: 0; axis.y: 1; axis.z: 0
    }

    states: State {
        name: "back"; when: container.isFlipped
        PropertyChanges { target: rotation; angle: 180 }
    }

    transitions: Transition {
        ParallelAnimation {
            NumberAnimation { target: rotation; properties: "angle"; duration: 600 }
            SequentialAnimation {
                NumberAnimation { target: container; property: "scale"; to: 0.75; duration: 300 }
                NumberAnimation { target: container; property: "scale"; to: 1.0; duration: 300 }
            }
        }
    }

    function flipped() {
        container.isFlipped = !container.isFlipped;
    }

}
