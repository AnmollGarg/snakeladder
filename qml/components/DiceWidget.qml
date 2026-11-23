import QtQuick 2.7
import Lomiri.Components 1.3

Rectangle {
    id: diceRoot

    property int value: 1
    property bool isRolling: false
    property bool enabled: true
    signal rollRequested()

    width: units.gu(8)
    height: units.gu(8)
    radius: units.dp(8)
    color: Theme.bgWhite
    opacity: enabled ? 1.0 : 0.5
    border.color: isRolling ? Theme.diceRolling : Theme.borderDefault
    border.width: 2

    Behavior on opacity {
        NumberAnimation { duration: 150 }
    }

    Text {
        id: diceLabel
        anchors.centerIn: parent
        text: value
        font.pixelSize: units.dp(30)
        font.bold: true
        color: isRolling ? Theme.diceRolling : Theme.textPrimary
        scale: isRolling ? 1.25 : 1.0

        Behavior on scale {
            NumberAnimation { duration: 80 }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: !isRolling && diceRoot.enabled
        onClicked: diceRoot.rollRequested()
    }
}
