import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

GridLayout {
    property var expertMode: false
    property var isTargetTop: [true, true, true]
    property var cardsArray: []
    property int cardCount: 0
    property var imgCardBottomArray: []
    property var imgCardTopArray: []
    property var targetsArray: []
    property var imgTargetArray: []
    readonly property int cardsMax: 81
    readonly property int targetsMax: 6
    readonly property int cardWidth: 218
    readonly property int cardHeight: 340

    columnSpacing: 10
    rowSpacing: 10
    columns: 5
    rows: 3

    Item {
        Layout.fillWidth: true
        Layout.preferredWidth: cardWidth
        Layout.rowSpan: 3
    }

    Repeater {
        id: targetItems
        model: 3
        TargetItem {
            onFlipOverTarget: flipOverTargets(index)
        }
    }

    Item {
        Layout.fillWidth: true
        Layout.preferredWidth: cardWidth
        Layout.rowSpan: 3
    }

    Repeater {
        id: cardBottomItems
        model: 3
        CardItem {
            onCardClicked: returnCards()
        }
    }

    Repeater {
        id: cardTopItems
        model: 3
        CardItem {
            onCardClicked: flipOverCards()
        }
    }

    Component.onCompleted: {
        var i;
        for (i = 0; i < targetItems.count; ++i) {
            imgTargetArray[i] = targetItems.itemAt(i).image;
        }
        initRandomTargetsArray();

        for (i = 0; i < cardBottomItems.count; ++i) {
            imgCardBottomArray[i] = cardBottomItems.itemAt(i).image;
            imgCardTopArray[i] = cardTopItems.itemAt(i).image;
        }
        initRandomCardsArray();
    }

    function initRandomTargetsArray() {
        if (expertMode) {
            var ext = 5;
            var max = targetsMax + ext;

            let randomNumber = Math.ceil(Math.random() * max);
            console.log("target1" + ": " + randomNumber);
            var start = 0;
            if (randomNumber > ext)
                start = 5;
            targetsArray[0] = start + randomNumber;
            imgTargetArray[0].source = "qrc:///images/targets/targetTop" + targetsArray[0] + ".png";

            randomNumber = Math.ceil(Math.random() * max);
            console.log("target2" + ": " + randomNumber);
            start = 5;
            if (randomNumber > ext)
                start = 11;
            targetsArray[1] = start + randomNumber;
            imgTargetArray[1].source = "qrc:///images/targets/targetTop" + targetsArray[1] + ".png";

            max = targetsMax;
            randomNumber = Math.ceil(Math.random() * max);
            console.log("target3" + ": " + randomNumber);
            start = 22;
            targetsArray[2] = start + randomNumber;
            imgTargetArray[2].source = "qrc:///images/targets/targetTop" + targetsArray[2] + ".png";
        } else {
            for (var i = 0; i < 3; i++) {
                let randomNumber = Math.ceil(Math.random() * targetsMax);
                targetsArray[i] = 10 + i*targetsMax + randomNumber;
                console.log("target" + i + ": " + targetsArray[i]);
                imgTargetArray[i].source = "qrc:///images/targets/targetTop" + targetsArray[i] + ".png";
            }
        }
    }

    function flipOverTargets(num) {
        if (isTargetTop[num])
            imgTargetArray[num].source = "qrc:///images/targets/targetBottom" + targetsArray[num] + ".png";
        else
            imgTargetArray[num].source = "qrc:///images/targets/targetTop" + targetsArray[num] + ".png";
        isTargetTop[num] = !isTargetTop[num];
    }

    function initRandomCardsArray() {
        var i;
        cardCount = 0;
        cardsArray = [];
        while (cardsArray.length < cardsMax) {
            var randomNumber = Math.ceil(Math.random() * cardsMax);
            var found = false;
            for (i = 0; i < cardsArray.length; i++) {
                if (cardsArray[i] === randomNumber) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                cardsArray[cardsArray.length]=randomNumber;
            }
        }

        for (i = 0; i < 3; i++) {
            imgCardBottomArray[i].source = "qrc:///images/cards/cardBottom" + cardsArray[cardCount] + ".png";
            console.log("bottom: " + cardCount);
            cardCount++;
        }
        for (i = 0; i < 3; i++) {
            imgCardTopArray[i].source = "qrc:///images/cards/cardTop" + cardsArray[cardCount] + ".png";
            console.log("top: " + cardCount);
            cardCount++;
        }
    }

    function flipOverCards() {
        if (cardCount >= cardsArray.length) {
            initRandomCardsArray();
        } else {
            var i;
            for (i = 0; i < 3; i++) {
                imgCardBottomArray[i].source = "qrc:///images/cards/cardBottom" + cardsArray[cardCount-3+i] + ".png";
                console.log("bottom: " + (cardCount-3+i));
            }
            for (i = 0; i < 3; i++) {
                imgCardTopArray[i].source = "qrc:///images/cards/cardTop" + cardsArray[cardCount] + ".png";
                console.log("top: " + cardCount);
                cardCount++;
            }
        }
    }

    function returnCards() {
        if (cardCount < 9)
            return;

        var i;
        for (i = 0; i < 3; i++) {
            imgCardBottomArray[i].source = "qrc:///images/cards/cardBottom" + cardsArray[cardCount-9+i] + ".png";
            console.log("bottom: " + (cardCount-9+i));
        }
        for (i = 0; i < 3; i++) {
            imgCardTopArray[i].source = "qrc:///images/cards/cardTop" + cardsArray[cardCount-6+i] + ".png";
            console.log("top: " + (cardCount-6+i));
        }
        cardCount = cardCount-3;
    }
}