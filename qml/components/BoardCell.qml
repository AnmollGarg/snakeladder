import QtQuick 2.7
import Lomiri.Components 1.3
import "../logic/GameLogic.js" as GameLogic

Rectangle {
    id: cellRoot

    property int cellNum: 1
    property bool isSnake: false
    property bool isLadder: false
    property int snakeTarget: 0
    property int ladderTarget: 0
    property bool isP1Here: false
    property bool isP2Here: false
    property bool isWinningCell: cellNum === 100
    property bool isGiantSnake: GameLogic.isGiantSnake(cellNum)
    property bool isAltCell: false

    color: {
        if (isWinningCell) return Theme.cellWinBg;
        if (isGiantSnake) return Theme.cellGiantSnakeBg;
        if (isSnake) return Theme.cellSnakeBg;
        if (isLadder) return Theme.cellLadderBg;
        return isAltCell ? Theme.cellAltBg : Theme.bgWhite;
    }
    border.color: isGiantSnake ? Theme.cellGiantSnakeBorder : Theme.borderDefault
    border.width: isGiantSnake ? 2 : 1

    Column {
        id: cellContent
        anchors.centerIn: parent
        anchors.verticalCenterOffset: (isP1Here || isP2Here) ? -units.dp(3.5) : 0
        spacing: units.dp(1)
        z: 1

                Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: cellNum
            font.pixelSize: {
                if (isSnake || isLadder || isWinningCell) {
                    return Math.max(units.dp(8), cellRoot.width * 0.22);
                }
                return Math.max(units.dp(10), cellRoot.width * 0.34);
            }
            color: {
                if (isWinningCell) return Theme.cellWinText;
                if (isGiantSnake) return Theme.cellGiantSnakeText;
                if (isSnake) return Theme.cellSnakeText;
                if (isLadder) return Theme.cellLadderText;
                return Theme.textSecondary;
            }
            font.bold: isWinningCell || isGiantSnake || isSnake || isLadder
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: isSnake || isLadder || isWinningCell
            spacing: units.dp(1)

            Image {
                id: indicatorIcon
                anchors.verticalCenter: parent.verticalCenter
                width: Math.max(units.dp(9), cellRoot.width * (isGiantSnake ? 0.30 : 0.25))
                height: width
                source: {
                    if (isWinningCell) return Qt.resolvedUrl("../../assets/trophy.svg");
                    if (isSnake) return Qt.resolvedUrl("../../assets/snake.svg");
                    if (isLadder) return Qt.resolvedUrl("../../assets/ladder.svg");
                    return "";
                }
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: !isWinningCell
                text: isSnake ? snakeTarget : (isLadder ? ladderTarget : "")
                font.pixelSize: Math.max(units.dp(7), cellRoot.width * 0.22)
                font.bold: true
                color: isSnake ? Theme.cellSnakeText : (isLadder ? Theme.cellLadderText : Theme.cellTrophyText)
            }
        }
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: units.dp(2)
        spacing: units.dp(2)

        Rectangle {
            visible: isP1Here
            width: Math.max(units.dp(12), cellRoot.width * 0.36)
            height: width
            radius: width / 2
            color: Theme.player1
            border.color: Theme.bgWhite
            border.width: 1.5

            Text {
                anchors.centerIn: parent
                text: "1"
                color: Theme.bgWhite
                font.pixelSize: parent.width * 0.65
                font.bold: true
            }
        }

        Rectangle {
            visible: isP2Here
            width: Math.max(units.dp(12), cellRoot.width * 0.36)
            height: width
            radius: width / 2
            color: Theme.player2
            border.color: Theme.bgWhite
            border.width: 1.5

            Text {
                anchors.centerIn: parent
                text: "2"
                color: Theme.bgWhite
                font.pixelSize: parent.width * 0.65
                font.bold: true
            }
        }
    }
}

