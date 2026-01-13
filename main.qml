import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    width: 350
    height: 600

    property int spacing: 10
    property int fontSize: 30
    property string displayText: "0"

    function addCommasToLastNumber() {
        // Match last number (digits and optional decimal)
        var match = displayText.match(/(\d+)(\.\d+)?$/)
        if (!match) return

        var integerPart = match[1]
        var decimalPart = match[2] || ""

        // Insert commas manually
        var result = ""
        var count = 0
        for (var i = integerPart.length - 1; i >= 0; i--) {
            result = integerPart[i] + result
            count++
            if (count % 3 === 0 && i !== 0) {
                result = "," + result
            }
        }

        // Replace old number with formatted number
        displayText = displayText.slice(0, displayText.length - match[0].length) + result + decimalPart
    }

    function appendChar(text) {
        if (displayText === "0") {
            displayText = text
        } else {
            displayText += text
        }

        addCommasToLastNumber()
    }

    function backspace() {
        displayText = displayText.slice(0, -1)
    }

    function clearAll() {
        displayText = "0"
    }

    function toggleSign() {
        // Case 1: last term is already wrapped
        var wrappedMatch = displayText.match(/\(-(\d*\.?\d+)\)$/)
        if (wrappedMatch) {
            // Remove the wrapping and restore the positive number
            var number = wrappedMatch[1]
            displayText = displayText.slice(0, displayText.length - wrappedMatch[0].length) + number
            return
        }

        // Case 2: last term is a plain number
        var plainMatch = displayText.match(/(-?\d*\.?\d+)$/)
        if (!plainMatch)
            return

        var number = plainMatch[1]
        var startIndex = displayText.length - number.length
        var prefix = displayText.slice(0, startIndex)

        displayText = prefix + "(-" + number.replace("-", "") + ")"
    }

    function evaluateExpression() {
        try {
            var expr = displayText
                .replace(/×/g, "*")
                .replace(/−/g, "-")
                .replace(/÷/g, "/");

            var result = Function('"use strict"; return (' + expr + ')')();

            if (isNaN(result) || !isFinite(result)) {
                displayText = "Error"
            } else {
                displayText = result.toString()
            }
        } catch (e) {
            displayText = "Error"
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"

        ColumnLayout {
            anchors.fill: parent

            Rectangle {
                id: textBox
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "black"

                Text {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 20

                    text: root.displayText
                    color: "white"
                    font.pointSize: 48
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideLeft
                }
            }

            GridLayout {
                columns: 4
                columnSpacing: spacing
                rowSpacing: spacing
                Layout.fillWidth: true
                Layout.margins: 20

                // Row 1
                CalcButton { label: "<"; backgroundColor: "#5b5b5b"; hoverColor: "#494949"; fontSize: fontSize; onClicked: root.backspace() }
                CalcButton { label: "AC"; backgroundColor: "#5b5b5b"; hoverColor: "#494949"; fontSize: fontSize; onClicked: root.clearAll() }
                CalcButton { label: "%"; backgroundColor: "#5b5b5b"; hoverColor: "#494949"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "÷"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: root.appendChar(label) }

                // Row 2
                CalcButton { label: "7"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "8"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "9"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "×"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: root.appendChar(label) }

                // Row 3
                CalcButton { label: "4"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "5"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "6"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "−"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: root.appendChar(label) }

                // Row 4
                CalcButton { label: "1"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "2"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "3"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "+"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: root.appendChar(label) }

                // Row 5
                CalcButton { label: "+/-"; fontSize: fontSize; onClicked: root.toggleSign() }
                CalcButton { label: "0"; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "."; fontSize: fontSize; onClicked: root.appendChar(label) }
                CalcButton { label: "="; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: root.evaluateExpression() }
            }
        }
    }
}
