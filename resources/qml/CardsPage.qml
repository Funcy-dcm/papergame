import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item {
    id: root
    readonly property int cardWidth: 218
    readonly property int cardHeight: 340
    readonly property int columnSpacing: 20
    property var ratio: cardHeight/cardWidth
    property alias targets: targetItems

    RowLayout {
        anchors.fill: parent
        Item {
            Layout.fillWidth: true
        }

        Column {
            Layout.fillHeight: true
            spacing: columnSpacing
            Repeater {
                id: targetItems
                model: 3
                TargetItem {
                    height: (parent.height-2*columnSpacing)/3
                    width: height/ratio
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Column {
            Layout.fillHeight: true
            spacing: columnSpacing
            Repeater {
                id: cardTopItems
                model: 3
                CardItem {
                    height: (parent.height-2*columnSpacing)/3
                    width: height/ratio
                    onCardClicked: cards.flipOverCards()
                }
            }
        }

        Item {
            width: columnSpacing
        }

        Column {
            Layout.fillHeight: true
            spacing: columnSpacing
            Repeater {
                id: cardBottomItems
                model: 3
                CardItem {
                    height: (parent.height-2*columnSpacing)/3
                    width: height/ratio
                    onCardClicked: cards.returnCards()
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Component.onCompleted: {
        cards.newGame();
    }

    Connections {
        target: cards
        onSetImageCardTop: cardTopItems.itemAt(num).imageSource = path
        onSetImageCardBottom: cardBottomItems.itemAt(num).imageSource = path
        onSetImageTarget: {
            targetItems.itemAt(num).frontSource = frontPath;
            targetItems.itemAt(num).backSource = backPath;
        }
    }
}

