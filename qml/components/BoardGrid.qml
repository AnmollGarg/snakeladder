import QtQuick 2.7
import Lomiri.Components 1.3
import "../logic/GameLogic.js" as GameLogic

Rectangle {
    id: gridRoot

    property int p1Pos: 1
    property int p2Pos: 1

    color: Theme.bgWhite
    radius: units.dp(4)
    clip: true
    border.color: Theme.borderBoard
    border.width: 2

    Grid {
        id: boardGrid
        anchors.fill: parent
        columns: 10
        rows: 10

        property real cellW: width / 10
        property real cellH: height / 10

        Repeater {
            model: 100
            delegate: BoardCell {
                width: boardGrid.cellW
                height: boardGrid.cellH

                property int calculatedCellNum: GameLogic.getCellNumber(index)
                cellNum: calculatedCellNum
                isAltCell: ((Math.floor(index / 10) + (index % 10)) % 2 === 1)
                isSnake: GameLogic.snakes[calculatedCellNum] !== undefined
                isLadder: GameLogic.ladders[calculatedCellNum] !== undefined
                snakeTarget: isSnake ? GameLogic.snakes[calculatedCellNum] : 0
                ladderTarget: isLadder ? GameLogic.ladders[calculatedCellNum] : 0
                isP1Here: p1Pos === calculatedCellNum
                isP2Here: p2Pos === calculatedCellNum
            }
        }
    }
}
