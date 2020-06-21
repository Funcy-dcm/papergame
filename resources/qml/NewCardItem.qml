import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: root

    property var imageSource
    property var angle: 90

    signal cardClicked()

    Image {
        id: image
        fillMode: Image.PreserveAspectFit
        width: root.width
        height: root.height
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

    transform: Rotation {
        id: rotation; origin.x: root.width/2; origin.y: root.height/2
        axis.x: 0; axis.y: 1; axis.z: 0
    }

    ParallelAnimation {
        id: flipAnimation
        SequentialAnimation {
            NumberAnimation { target: root; property: "scale"; to: 0.75; duration: 300 }
            ScriptAction { script: image.source = imageSource; }
            NumberAnimation { target: root; property: "scale"; to: 1.0; duration: 300 }
        }
        SequentialAnimation {
            NumberAnimation { target: rotation; properties: "angle"; to: angle; duration: 300 }
            NumberAnimation { target: rotation; properties: "angle"; to: 0; duration: 300 }
        }
    }
    ParallelAnimation {
        id: returnAnimation
        SequentialAnimation {
            NumberAnimation { target: root; property: "scale"; to: 0.05; duration: 300 }
            ScriptAction { script: image.source = imageSource; }
            NumberAnimation { target: root; property: "scale"; to: 1.0; duration: 300 }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            cardClicked()
        }
    }

    function setImageSource(source, isFlipped) {
        imageSource = source;
        if (isFlipped)
            flipAnimation.start();
        else
            returnAnimation.start();
    }
}
