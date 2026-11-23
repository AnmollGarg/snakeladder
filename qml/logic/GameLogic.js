.pragma library

var snakes = Object.freeze({
    98: 8,
    95: 56,
    92: 72,
    89: 68,
    84: 53,
    78: 42,
    73: 32,
    66: 45,
    62: 18,
    55: 23,
    49: 15,
    38: 16,
    31: 14,
    26: 10,
    17: 5
});

var ladders = Object.freeze({
    4: 16,
    9: 22,
    12: 25,
    20: 33,
    28: 39,
    36: 47,
    43: 54,
    51: 64,
    63: 75,
    71: 82,
    80: 91
});

var BIG_SNAKE_THRESHOLD = 50;

function isGiantSnake(cellNum) {
    if (snakes[cellNum] === undefined) return false;
    return (cellNum - snakes[cellNum]) >= BIG_SNAKE_THRESHOLD;
}

function getCellNumber(index) {
    var rowFromTop = Math.floor(index / 10);
    var col = index % 10;
    var rowFromBottom = 9 - rowFromTop;
    var cellStart = rowFromBottom * 10;
    if (rowFromBottom % 2 === 0) {
        return cellStart + col + 1;
    } else {
        return cellStart + (9 - col) + 1;
    }
}

function calculateMove(playerNumber, currentPos, diceValue) {
    var targetPos = currentPos + diceValue;
    var result = {
        finalPos: currentPos,
        diceValue: diceValue,
        ladderClimbed: false,
        ladderStart: 0,
        ladderEnd: 0,
        snakeBitten: false,
        snakeStart: 0,
        snakeEnd: 0,
        isBigSnake: false,
        bounced: false,
        won: false
    };

    if (targetPos > 100) {
        result.bounced = true;
        result.finalPos = currentPos;
        return result;
    }

    if (targetPos === 100) {
        result.finalPos = 100;
        result.won = true;
        return result;
    }

    if (ladders[targetPos] !== undefined) {
        result.ladderClimbed = true;
        result.ladderStart = targetPos;
        result.ladderEnd = ladders[targetPos];
        result.finalPos = ladders[targetPos];
        return result;
    }

    if (snakes[targetPos] !== undefined) {
        result.snakeBitten = true;
        result.snakeStart = targetPos;
        result.snakeEnd = snakes[targetPos];
        result.finalPos = snakes[targetPos];
        result.isBigSnake = isGiantSnake(targetPos);
        return result;
    }

    result.finalPos = targetPos;
    return result;
}

function getRandomDice() {
    return Math.floor(Math.random() * 6) + 1;
}

