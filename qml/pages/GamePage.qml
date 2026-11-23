import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3
import "../components"

Page {
    id: gamePage

    signal openAboutRequested()

    GameState {
        id: gameState
        onDiceRollStarted: soundManager.playDice()
        onLadderClimbed: {
            soundManager.playLadder();
            eventPopup.showLadder(playerNum, fromPos, toPos);
        }
        onSnakeBitten: {
            if (isBig) {
                soundManager.playGiantSnake();
            } else {
                soundManager.playSnake();
            }
            eventPopup.showSnake(playerNum, fromPos, toPos, isBig);
        }
        onPlayerWon: {
            soundManager.playWin();
            eventPopup.showWin(playerNum);
        }
        onGameReset: eventPopup.dismiss()
    }

    SoundManager {
        id: soundManager
    }

    header: PageHeader {
        id: header
        title: i18n.tr("Snakes & Ladders")
        trailingActionBar.actions: [
            Action {
                iconName: soundManager.soundEnabled ? "audio-volume-high" : "audio-volume-muted"
                text: soundManager.soundEnabled ? i18n.tr("Mute") : i18n.tr("Unmute")
                onTriggered: soundManager.soundEnabled = !soundManager.soundEnabled
            },
            Action {
                iconName: "info"
                text: i18n.tr("Rules")
                onTriggered: gamePage.openAboutRequested()
            },
            Action {
                iconName: "reload"
                text: i18n.tr("Restart")
                onTriggered: gameState.resetGame()
            }
        ]
    }

    Rectangle {
        id: pageContent
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        color: Theme.bgPrimary

        readonly property real boardSize: Math.max(units.gu(24), Math.min(width - units.gu(2), height - units.gu(18), units.gu(46)))

        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: Math.max(height, contentCol.height + units.gu(2))
            clip: true

            Column {
                id: contentCol
                width: parent.width
                spacing: units.gu(1)
                topPadding: units.gu(1)
                bottomPadding: units.gu(1)

                BoardGrid {
                    id: board
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: pageContent.boardSize
                    height: width
                    p1Pos: gameState.p1Pos
                    p2Pos: gameState.p2Pos
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: board.width
                    spacing: units.gu(1)

                    PlayerCard {
                        Layout.fillWidth: true
                        playerNumber: 1
                        playerName: i18n.tr("Player 1")
                        playerColor: Theme.player1
                        position: gameState.p1Pos
                        isActive: gameState.playerTurn === 1 && gameState.winner === 0
                    }

                    DiceWidget {
                        value: gameState.diceValue
                        isRolling: gameState.isRolling
                        enabled: !gameState.isRolling && !gameState.isMoving && gameState.winner === 0
                        onRollRequested: gameState.rollDice()
                    }

                    PlayerCard {
                        Layout.fillWidth: true
                        playerNumber: 2
                        playerName: i18n.tr("Player 2")
                        playerColor: Theme.player2
                        position: gameState.p2Pos
                        isActive: gameState.playerTurn === 2 && gameState.winner === 0
                    }
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: board.width
                    spacing: units.gu(1)

                    Button {
                        id: rollBtn
                        Layout.fillWidth: true
                        height: units.gu(5)
                        text: {
                            if (gameState.winner !== 0) return i18n.tr("Play Again");
                            if (gameState.isRolling) return i18n.tr("Rolling...");
                            if (gameState.isMoving) return i18n.tr("Moving...");
                            return i18n.tr("Roll Dice");
                        }
                        color: {
                            if (gameState.winner !== 0) return Theme.popupWinAccent;
                            return gameState.playerTurn === 1 ? Theme.player1 : Theme.player2;
                        }
                        enabled: !gameState.isRolling && !gameState.isMoving
                        onClicked: {
                            if (gameState.winner !== 0) {
                                gameState.resetGame();
                            } else {
                                gameState.rollDice();
                            }
                        }
                    }

                    Button {
                        Layout.preferredWidth: units.gu(12)
                        height: units.gu(5)
                        text: i18n.tr("Reset")
                        color: Theme.bgWhite
                        onClicked: gameState.resetGame()
                    }
                }
            }
        }

        EventPopup {
            id: eventPopup
            anchors.fill: parent
            z: 100
        }
    }
}
