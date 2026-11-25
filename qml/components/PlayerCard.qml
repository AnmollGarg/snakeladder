import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3

Rectangle {
    id: cardRoot

    property int playerNumber: 1
    property string playerName: "Player " + playerNumber
    property color playerColor: playerNumber === 1 ? Theme.player1 : Theme.player2
    property int position: 1
    property bool isActive: false

    property int wins: 0

    height: units.gu(8)
    radius: units.dp(6)

    color: {
        if (!isActive) return Theme.bgWhite;
        return playerNumber === 1 ? Theme.player1ActiveBg : Theme.player2ActiveBg;
    }

    border.color: isActive ? playerColor : Theme.borderDefault
    border.width: isActive ? 2 : 1

    Column {
        anchors.centerIn: parent
        spacing: units.dp(4)

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: units.dp(6)

            Rectangle {
                width: units.gu(1.5)
                height: width
                radius: width / 2
                color: playerColor
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: playerName
                color: Theme.textPrimary
                font.bold: isActive
                textSize: Label.Medium
            }
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Square: %1").arg(position)
            color: Theme.textTertiary
            font.bold: isActive
            textSize: Label.Small
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Wins: %1").arg(wins)
            color: Theme.textSecondary
            textSize: Label.Small
        }
    }
}
