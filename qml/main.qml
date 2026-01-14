import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    width: 350
    height: 600

    property int spacing: 10
    property int fontSize: 30

    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"

        ColumnLayout {
            anchors.fill: parent

            CalcTextEdit {}

            GridLayout {
                columns: 4
                columnSpacing: spacing
                rowSpacing: spacing
                Layout.fillWidth: true
                Layout.margins: 20

                // Row 1
                CalcButton { label: "<"; backgroundColor: "#5b5b5b"; hoverColor: "#494949"; fontSize: fontSize; onClicked: calculator.backspace() }
                CalcButton { label: "AC"; backgroundColor: "#5b5b5b"; hoverColor: "#494949"; fontSize: fontSize; onClicked: calculator.clearAll() }
                CalcButton { label: "%"; backgroundColor: "#5b5b5b"; hoverColor: "#494949"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "÷"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: calculator.appendChar(label) }

                // Row 2
                CalcButton { label: "7"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "8"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "9"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "×"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: calculator.appendChar(label) }

                // Row 3
                CalcButton { label: "4"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "5"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "6"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "−"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: calculator.appendChar(label) }

                // Row 4
                CalcButton { label: "1"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "2"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "3"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "+"; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: calculator.appendChar(label) }

                // Row 5
                CalcButton { label: "+/-"; fontSize: fontSize; onClicked: calculator.toggleSign() }
                CalcButton { label: "0"; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "."; fontSize: fontSize; onClicked: calculator.appendChar(label) }
                CalcButton { label: "="; backgroundColor: "#ff9200"; hoverColor: "#cc7500"; fontSize: fontSize; onClicked: calculator.evaluateExpression() }
            }
        }
    }
}
