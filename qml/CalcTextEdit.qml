import QtQuick 2.15
import QtQuick.Layouts 1.15


Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "black"

    Text {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        text: calculator.displayText
        color: "white"
        font.pointSize: 48
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideLeft
    }
}