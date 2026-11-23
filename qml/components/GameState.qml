import QtQuick 2.7
import "../logic/GameLogic.js" as GameLogic

Item {
    id: gameState

    property int playerTurn: 1
    property int p1Pos: 1
    property int p2Pos: 1
    property int diceValue: 1
    property bool isRolling: false
    property bool isMoving: false
    property int winner: 0

    property int _animPlayer: 1
    property int _animCurrentStep: 1
    property int _animTargetStep: 1
    property var _animMoveResult: null
    property int _animPhase: 0

    signal diceRollStarted()
    signal ladderClimbed(int playerNum, int fromPos, int toPos)
    signal snakeBitten(int playerNum, int fromPos, int toPos, bool isBig)
    signal playerWon(int playerNum)
    signal gameReset()

    function rollDice() {
        if (isRolling || isMoving || winner !== 0) return;
        diceRollStarted();
        isRolling = true;
        rollTimer.counter = 0;
        rollTimer.start();
    }

    function resetGame() {
        stepTimer.stop();
        rollTimer.stop();
        isRolling = false;
        isMoving = false;
        _animPhase = 0;
        p1Pos = 1;
        p2Pos = 1;
        diceValue = 1;
        playerTurn = 1;
        winner = 0;
        gameReset();
    }

    function executeMove(finalDice) {
        diceValue = finalDice;
        var currentP = playerTurn;
        var currentPos = (currentP === 1) ? p1Pos : p2Pos;
        var moveResult = GameLogic.calculateMove(currentP, currentPos, finalDice);

        if (moveResult.bounced) {
            if (finalDice !== 6) {
                playerTurn = (playerTurn === 1) ? 2 : 1;
            }
            return;
        }

        isMoving = true;
        _animPlayer = currentP;
        _animCurrentStep = currentPos;
        _animTargetStep = currentPos + finalDice;
        _animMoveResult = moveResult;
        _animPhase = 1;
        stepTimer.interval = 180;
        stepTimer.restart();
    }

    function finishMove() {
        isMoving = false;
        _animPhase = 0;

        if (_animMoveResult && _animMoveResult.won) {
            winner = _animPlayer;
            playerWon(_animPlayer);
            return;
        }

        if (diceValue !== 6) {
            playerTurn = (playerTurn === 1) ? 2 : 1;
        }
    }

    Timer {
        id: stepTimer
        repeat: false
        onTriggered: {
            if (_animPhase === 1) {
                _animCurrentStep++;
                if (_animPlayer === 1) {
                    p1Pos = _animCurrentStep;
                } else {
                    p2Pos = _animCurrentStep;
                }

                if (_animCurrentStep < _animTargetStep) {
                    interval = 180;
                    restart();
                } else {
                    if (_animMoveResult.ladderClimbed || _animMoveResult.snakeBitten) {
                        _animPhase = 2;
                        interval = 400;
                        restart();
                    } else {
                        finishMove();
                    }
                }
            } else if (_animPhase === 2) {
                if (_animMoveResult.ladderClimbed) {
                    ladderClimbed(_animPlayer, _animMoveResult.ladderStart, _animMoveResult.ladderEnd);
                    if (_animPlayer === 1) {
                        p1Pos = _animMoveResult.ladderEnd;
                    } else {
                        p2Pos = _animMoveResult.ladderEnd;
                    }
                } else if (_animMoveResult.snakeBitten) {
                    snakeBitten(_animPlayer, _animMoveResult.snakeStart, _animMoveResult.snakeEnd, _animMoveResult.isBigSnake);
                    if (_animPlayer === 1) {
                        p1Pos = _animMoveResult.snakeEnd;
                    } else {
                        p2Pos = _animMoveResult.snakeEnd;
                    }
                }

                _animPhase = 3;
                interval = 500;
                restart();
            } else if (_animPhase === 3) {
                finishMove();
            }
        }
    }

    Timer {
        id: rollTimer
        interval: 60
        repeat: true
        property int counter: 0
        onTriggered: {
            gameState.diceValue = GameLogic.getRandomDice();
            counter++;
            if (counter > 8) {
                stop();
                gameState.isRolling = false;
                gameState.executeMove(gameState.diceValue);
            }
        }
    }
}
