import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Label {
            id: playerAidsLabel
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 22
            font.bold: true
        }
        Item {
            id: help
            property var ratio: image.height/image.width
            Layout.fillHeight: true
            Layout.preferredWidth: height/ratio

            Layout.alignment: Qt.AlignHCenter
            Image {
                id: image
                fillMode: Image.PreserveAspectFit
                source: "qrc:///images/help.png"
                visible: false
            }
            OpacityMask {
                anchors.fill: help
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
            Layout.alignment: Qt.AlignHCenter
            ColumnLayout {
                anchors.fill: parent
                Label {
                    id: shortcutsLabel
                    Layout.alignment: Qt.AlignHCenter
                    font.pixelSize: 22
                    font.bold: true
                }
                Repeater {
                    id: keyLabels
                    model: 7
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        font.pixelSize: 20
                    }
                }
                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }

    function retranslateUi() {
        playerAidsLabel.text = qsTr("Player Aids");
        shortcutsLabel.text = qsTr("Shortcuts");
        keyLabels.itemAt(0).text = qsTr("Flip over cards") + ": <i><b>Space</b></i>";
        keyLabels.itemAt(1).text = qsTr("Return cards") + ": <i><b>Backspace</b></i>";
        keyLabels.itemAt(2).text = qsTr("Flip over City Plan 1-3") + ": <i><b>1-3</b></i>";
        keyLabels.itemAt(3).text = qsTr("New game") + ": <i><b>Ctrl+N</b></i>";
        keyLabels.itemAt(4).text = qsTr("Shuffle City Plans") + ": <i><b>Ctrl+P</b></i>";
        keyLabels.itemAt(5).text = qsTr("Shuffle cards") + ": <i><b>Ctrl+C</b></i>";
        keyLabels.itemAt(6).text = qsTr("Full Screen") + ": <i><b>F11</b></i>";
    }
}
