import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtWebEngine 1.0

ApplicationWindow {
    id: root
    width: 640
    height: 480
    visible: true

    Component {
        id: itemDelegate
        Item {
            width: root.width
            height:25
            Text { text: modelData}
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    list.currentIndex = index
                }
            }
        }
    }
    WebEngineView {
        id: webview
        url: "default.html"
        anchors.fill: parent
//        width: root.width
//        height: (root.height - 100) / 2
    }
/*
    ListView {
        id: list
        anchors.fill: parent
        model:dataset

        focus:true
        highlightMoveDuration: 0
        highlight: Rectangle {color:"red"; radius:5}

        delegate: itemDelegate
    }
*/
}
