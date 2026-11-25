import QtQuick 2.7
import Lomiri.Components 1.3
import "../components"

Page {
    id: aboutPage

    header: PageHeader {
        id: header
        title: i18n.tr("Rules & About")
    }

    Rectangle {
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        color: Theme.bgPrimary

        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: contentCol.height + units.gu(4)
            clip: true

            Column {
                id: contentCol
                width: Math.min(parent.width - units.gu(4), units.gu(46))
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(2)
                topPadding: units.gu(2)

                Label {
                    text: i18n.tr("How to Play")
                    color: Theme.textPrimary
                    textSize: Label.Large
                    font.bold: true
                }

                Rectangle {
                    width: parent.width
                    height: rulesCol.height + units.gu(2)
                    color: Theme.bgWhite
                    radius: units.dp(6)
                    border.color: Theme.borderDefault
                    border.width: 1

                    Column {
                        id: rulesCol
                        width: parent.width - units.gu(2)
                        anchors.centerIn: parent
                        spacing: units.gu(1)

                        Label {
                            width: parent.width
                            text: i18n.tr(
                                "• Two players take turns rolling the dice.\n" +
                                "• Landing on the bottom of a Ladder climbs you up to its top.\n" +
                                "• Landing on the head of a Snake slides you down to its tail.\n" +
                                "• Rolling a 6 earns you an extra turn!\n" +
                                "• You must reach square 100 by exact roll to win."
                            )
                            color: Theme.textSecondary
                            textSize: Label.Medium          
                            wrapMode: Text.Wrap
                            lineHeight: 1.4
                        }
                    }
                }

                Label {
                    text: i18n.tr("About")
                    color: Theme.textPrimary
                    textSize: Label.Large
                    font.bold: true
                }

                Rectangle {
                    width: parent.width
                    height: aboutText.height + units.gu(2)
                    color: Theme.bgWhite
                    radius: units.dp(6)
                    border.color: Theme.borderDefault
                    border.width: 1

                    Label {
                        id: aboutText
                        anchors.centerIn: parent
                        width: parent.width - units.gu(2)
                        text: i18n.tr("Offline 2-player Snake and Ladder game built for Ubuntu Touch using QML and CMake.")
                        color: Theme.textMuted
                        wrapMode: Text.Wrap
                        textSize: Label.Medium          
                    }
                }
            }
        }
    }
}
