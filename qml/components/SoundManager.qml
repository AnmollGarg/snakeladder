import QtQuick 2.7
import QtMultimedia 5.0
import Qt.labs.settings 1.0

Item {
    id: soundManager

    property bool soundEnabled: true

    Settings {
        id: audioSettings
        category: "Audio"
        property alias soundEnabled: soundManager.soundEnabled
    }

    SoundEffect {
        id: diceAudio
        source: Qt.resolvedUrl("../../assets/sounds/dice.wav")
    }

    SoundEffect {
        id: ladderAudio
        source: Qt.resolvedUrl("../../assets/sounds/ladder.wav")
    }

    SoundEffect {
        id: snakeAudio
        source: Qt.resolvedUrl("../../assets/sounds/snake.wav")
    }

    SoundEffect {
        id: giantSnakeAudio
        source: Qt.resolvedUrl("../../assets/sounds/giantsnake.wav")
    }

    SoundEffect {
        id: winAudio
        source: Qt.resolvedUrl("../../assets/sounds/win.wav")
    }

    function playDice() {
        if (!soundEnabled) return;
        diceAudio.play();
    }

    function playLadder() {
        if (!soundEnabled) return;
        ladderAudio.play();
    }

    function playSnake() {
        if (!soundEnabled) return;
        snakeAudio.play();
    }

    function playGiantSnake() {
        if (!soundEnabled) return;
        giantSnakeAudio.play();
    }

    function playWin() {
        if (!soundEnabled) return;
        winAudio.play();
    }
}
