/****************************************************************************
**
** PaperGame is a open-source cross-platform board game
** Copyright (C) 2020 Shilyaev Egor <egor.shilyaev@gmail.com>
**
** This program is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program.  If not, see <https://www.gnu.org/licenses/>.
**
****************************************************************************/
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: mainWindow
    title: "Paper Game"

    enum NumPage {
        Sheet,
        Cards,
        Help
    }

    minimumHeight: 480
    minimumWidth: 640

    Material.accent: Material.Orange

    readonly property int initPage: 1

    Action {
        id: fullScreenAction
        icon.source: "qrc:///images/fullScreen.png"
        shortcut: "F11"
        onTriggered: {
            if (visibility != Window.FullScreen)
                showFullScreen();
            else
                showMaximized();
        }
    }
    Action {
        shortcut: "Esc"
        onTriggered: {
            if (visibility === Window.FullScreen)
                showMaximized();
        }
    }
    Action {
        shortcut: "1"
        onTriggered: cardPage.targets.itemAt(0).flipped()
    }
    Action {
        shortcut: "2"
        onTriggered: cardPage.targets.itemAt(1).flipped()
    }
    Action {
        shortcut: "3"
        onTriggered: cardPage.targets.itemAt(2).flipped()
    }
    Action {
        id: returnCardsAction
        shortcut: "Backspace"
        onTriggered: cards.returnCards()
    }
    Action {
        id: flipOverCardsAction
        shortcut: "Space"
        onTriggered: cards.flipOverCards()
    }

    Item {
        id: mainItem
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10

        ColumnLayout {
            anchors.fill: parent
            spacing: 5

            SwipeView {
                id: swipeView
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: initPage

                Item {
                    id: sheetLayout
                }
                //                SheetPage {
                //                    id: sheetLayout
                //                }

                CardsPage {
                    id: cardPage
                }

                HelpPage {
                    id: helpPage
                }

                onCurrentIndexChanged: {
                    pageIndicator.currentIndex = swipeView.currentIndex;
                    if (swipeView.currentIndex === MainWindow.NumPage.Help)
                        helpAction.text = qsTr("Cards");
                    else
                        helpAction.text = qsTr("Help");
                }
            }

            PageIndicator {
                id: pageIndicator
                Layout.alignment: Qt.AlignHCenter
                interactive: true
                currentIndex: initPage
                count: swipeView.count
                onCurrentIndexChanged: {
                    swipeView.currentIndex = pageIndicator.currentIndex;
                }
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.top: parent.top
            spacing: 0

            ToolButton {
                focusPolicy: Qt.NoFocus
                icon.color: "transparent"
                icon.source: "qrc:///images/languages/flag_great_britain.png"
                onClicked: mainApp.setLanguage("en")
            }
            ToolButton {
                focusPolicy: Qt.NoFocus
                icon.color: "transparent"
                icon.source: "qrc:///images/languages/flag_russia.png"
                onClicked: mainApp.setLanguage("ru")
            }
        }

        Text {
            id: warningText
            color: "grey"
            anchors.top: parent.bottom
            transform: Rotation { origin.x: 0; origin.y: 0; angle: -90}
        }

        Button {
            id: menuButton
            focusPolicy: Qt.NoFocus
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            onClicked: menu.open()

            Menu {
                id: menu
                y: menuButton.height

                MenuItem {
                    id: helpAction
                    onClicked: {
                        if (swipeView.currentIndex === MainWindow.NumPage.Help)
                            swipeView.currentIndex = MainWindow.NumPage.Cards
                        else
                            swipeView.currentIndex = MainWindow.NumPage.Help
                    }
                }

                MenuSeparator { }

                Action {
                    id: newGameAction
                    shortcut: "ctrl+n"
                    onTriggered: cards.newGame()
                }
                Action {
                    id: mixTargetsAction
                    shortcut: "ctrl+p"
                    onTriggered: cards.randomTargets()
                }
                Action {
                    id: mixCardsAction
                    shortcut: "ctrl+c"
                    onTriggered: cards.randomCards()
                }

                MenuSeparator { }

                MenuItem {
                    id: rulesAction
                    onClicked: Qt.openUrlExternally("file:///" +
                                                    mainApp.dataDirPath() + "/rules_" +
                                                    mainApp.getLanguage() + ".pdf")
                }
                MenuItem {
                    id: sheetAction
                    onClicked: Qt.openUrlExternally("file:///" +
                                                    mainApp.dataDirPath() + "/sheet.pdf")
                }
                MenuItem {
                    id: expertModeAction
                    checkable: true
                    checked: cards.getExpertMode()
                    onClicked: {
                        cards.setExpertMode(checked);
                        cards.newGame();
                    }
                }

                MenuSeparator { }

                Action {
                    id: exitAction
                    shortcut: "Ctrl+Q"
                    onTriggered: close()
                }
            }
        }

        ToolButton {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            focusPolicy: Qt.NoFocus
            icon.color: "transparent"
            display: AbstractButton.IconOnly
            action: fullScreenAction
        }
    }

    onClosing: {
        mainApp.quitApp()
    }

    Component.onCompleted: {
        retranslateUi();
    }

    Connections {
        target: mainApp
        onLanguageChanged: retranslateUi()
        onShowMainWindow: {
//            showNormal();
            showMaximized();
        }
    }

    function retranslateUi() {
        warningText.text = qsTr("All materials are provided for informational, non-commercial purposes only");
        menuButton.text = qsTr("Menu");
        helpAction.text = qsTr("Help");
        rulesAction.text = qsTr("Rulebook...");
        sheetAction.text = qsTr("Player sheet...");
        newGameAction.text = qsTr("New game");
        mixTargetsAction.text = qsTr("Shuffle City Plans");
        mixCardsAction.text = qsTr("Shuffle cards");
        expertModeAction.text = qsTr("Expert mode");
        returnCardsAction.text = qsTr("Return cards");
        flipOverCardsAction.text = qsTr("Flip over cards");
        exitAction.text = qsTr("Exit");

        helpPage.retranslateUi();
    }
}
