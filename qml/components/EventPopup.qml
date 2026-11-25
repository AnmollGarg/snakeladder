import QtQuick 2.7
import Lomiri.Components 1.3

Item {
    id: popupRoot

    property string popupTitle: ""
    property string popupMessage: ""
    property bool isSnake: false
    property bool isLadder: false
    property bool isWin: false

    readonly property color accentColor: isWin ? Theme.popupWinAccent : (isSnake ? Theme.popupSnakeAccent : Theme.popupLadderAccent)
    readonly property color bgColor: isWin ? Theme.popupWinBg : (isSnake ? Theme.popupSnakeBg : Theme.popupLadderBg)
    readonly property color borderColorVal: isWin ? Theme.popupWinBorder : (isSnake ? Theme.popupSnakeBorder : Theme.popupLadderBorder)

    property real showState: 0
    visible: showState > 0

    Behavior on showState {
        NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.overlayBlack
        opacity: popupRoot.showState * 0.35

        MouseArea {
            anchors.fill: parent
            onClicked: popupRoot.dismiss()
        }
    }

    Rectangle {
        id: card
        anchors.centerIn: parent
        width: Math.min(popupRoot.width - units.gu(4), units.gu(42))
        height: contentColumn.height + units.gu(3)
        radius: units.dp(8)
        color: bgColor
        border.color: borderColorVal
        border.width: 2
        opacity: popupRoot.showState
        scale: 0.9 + (popupRoot.showState * 0.1)

        Column {
            id: contentColumn
            anchors.centerIn: parent
            width: parent.width - units.gu(3)
            spacing: units.gu(1)

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(1)

                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    width: units.gu(3)
                    height: width
                    source: isWin ? Qt.resolvedUrl("../../assets/trophy.svg") : (isSnake ? Qt.resolvedUrl("../../assets/snake.svg") : Qt.resolvedUrl("../../assets/ladder.svg"))
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }

                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: popupTitle
                    textSize: Label.Large
                    font.bold: true
                    color: accentColor
                }
            }

            Label {
                width: parent.width
                text: popupMessage
                color: Theme.textBody
                textSize: Label.Medium
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                lineHeight: 1.3
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: isWin ? i18n.tr("Tap to close") : i18n.tr("Tap to close (auto closes in 3s)")
                color: Theme.textSubtle
                textSize: Label.Small
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: popupRoot.dismiss()
        }
    }

    Timer {
        id: autoDismissTimer
        interval: 3000
        repeat: false
        onTriggered: popupRoot.dismiss()
    }

    function showLadder(playerNum, fromPos, toPos) {
        isWin = false;
        isLadder = true;
        isSnake = false;
        popupTitle = i18n.tr("Ladder Climbed!");
        popupMessage = i18n.tr("Player %1 climbed up from %2 to %3!").arg(playerNum).arg(fromPos).arg(toPos);
        present();
    }

    function showSnake(playerNum, fromPos, toPos, isBigSnake) {
        isWin = false;
        isSnake = true;
        isLadder = false;
        if (isBigSnake) {
            popupTitle = i18n.tr("GIANT SNAKE BITE!");
            popupMessage = i18n.tr("DISASTER! Player %1 stepped on square %2 and plummeted all the way down to %3!").arg(playerNum).arg(fromPos).arg(toPos);
        } else {
            popupTitle = i18n.tr("Snake Bite!");
            popupMessage = i18n.tr("Oh no! Player %1 was bitten at %2 and slid down to %3!").arg(playerNum).arg(fromPos).arg(toPos);
        }
        present();
    }

    function showWin(playerNum) {
        isWin = true;
        isSnake = false;
        isLadder = false;
        popupTitle = i18n.tr("VICTORY!");
        popupMessage = i18n.tr("Player %1 reached square 100 and won the game!").arg(playerNum);
        present();
    }

    function present() {
        if (!isWin) {
            autoDismissTimer.restart();
        } else {
            autoDismissTimer.stop();
        }
        popupRoot.showState = 1.0;
    }

    function dismiss() {
        autoDismissTimer.stop();
        popupRoot.showState = 0;
    }
}

