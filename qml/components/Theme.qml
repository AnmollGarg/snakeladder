pragma Singleton
import QtQuick 2.7

QtObject {
    // Official Ubuntu Suru Palette
    readonly property color player1:         "#E95420"
    readonly property color player2:         "#77216F"
    readonly property color player1ActiveBg: "#FDF3F0"
    readonly property color player2ActiveBg: "#F6ECF5"
    readonly property color bgPrimary:    "#F7F7F7"
    readonly property color bgWhite:      "#FFFFFF"
    readonly property color overlayBlack: "#111111"

    readonly property color borderDefault: "#cbd5e1"
    readonly property color borderBoard:   "#94a3b8"

    readonly property color textPrimary:   "#0f172a"
    readonly property color textSecondary: "#334155"
    readonly property color textTertiary:  "#475569"
    readonly property color textMuted:     "#64748b"
    readonly property color textSubtle:    "#94a3b8"
    readonly property color textBody:      "#1e293b"

    readonly property color cellWinBg:          "#fef3c7"
    readonly property color cellGiantSnakeBg:   "#fecaca"
    readonly property color cellSnakeBg:        "#fee2e2"
    readonly property color cellLadderBg:       "#dcfce7"
    readonly property color cellAltBg:          "#f8fafc"
    readonly property color cellGiantSnakeBorder: "#ef4444"

    readonly property color cellWinText:        "#92400e"
    readonly property color cellGiantSnakeText: "#991b1b"
    readonly property color cellSnakeText:      "#b91c1c"
    readonly property color cellLadderText:     "#15803d"
    readonly property color cellTrophyText:     "#b45309"

    readonly property color diceRolling: "#f59e0b"

    readonly property color popupWinAccent: "#d97706"
    readonly property color popupWinBg:     "#fefce8"
    readonly property color popupWinBorder: "#fde047"

    readonly property color popupSnakeAccent: "#b91c1c"
    readonly property color popupSnakeBg:     "#fef2f2"
    readonly property color popupSnakeBorder: "#fca5a5"

    readonly property color popupLadderAccent: "#15803d"
    readonly property color popupLadderBg:     "#f0fdf4"
    readonly property color popupLadderBorder: "#86efac"
}
