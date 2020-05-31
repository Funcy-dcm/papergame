import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Popup {
    id: root
    property alias text: textField.text
    signal accepted()
    signal rejected()

    modal: true
    focus: true
    anchors.centerIn: parent

    background: Rectangle {
        color: "#444444"
        opacity: 0.9
        implicitWidth: 200
        implicitHeight: 140
        radius: 4
        ColumnLayout {
            id: mainLayout
            anchors.fill: parent
            anchors.margins: 10

            Label {
                color: "white"
                font.bold: true
                text: qsTr("City name")
            }

            TextField {
                id: textField
                color: "white"
                Layout.fillWidth: true;
                focus: true
            }
            Item {
                Layout.fillHeight: true;
            }

            Row {
                Layout.alignment: Qt.AlignRight
                StyleButton {
                    text: qsTr("Ok")
                    onClicked: {
                        accepted();
                        close();
                    }
                }
                StyleButton {
                    text: qsTr("Cancel")
                    onClicked: {
                        rejected();
                        close();
                    }
                }
            }
        }
    }
    onAboutToShow: {
        text = "";
        textField.focus = true;
    }
}
