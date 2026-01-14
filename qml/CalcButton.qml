import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    Layout.fillWidth: true
    Layout.preferredHeight: width
    radius: height / 2

    property string label: ""
    property string backgroundColor: "#2f2f2f"
    property string hoverColor: "#262626"
    property int fontSize: 24

    color: mouseArea.containsMouse ? hoverColor : backgroundColor

    Text {
        anchors.centerIn: parent
        text: root.label
        font.pointSize: root.fontSize
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked(root.label)
        hoverEnabled: true
    }

    signal clicked(string value)
}
