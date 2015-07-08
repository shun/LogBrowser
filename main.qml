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

    FileDialog {
        id:filedialog

        onAccepted: {
            console.debug("accept")
            visible = false
        }

        onRejected: {
            visible = false
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

        WebEngineView {
            id: webview
            url: "default.html"
            height: root.height / 2
        }


        Rectangle {
            ListView {
                id: list
                model:dataset
                clip: true


                width:root.width / 4 * 3
                height: root.height / 2
                x:0
                focus:true
                highlightMoveDuration: 0
                highlightResizeDuration:0
                highlight: Rectangle {color:"red"; radius:5}

                delegate: itemDelegate
            }

            Rectangle {
                id: ctrlpane
                width:root.width / 4
                color:"green"
                x:list.width
                height: root.height / 2

                Button {
                    x: 27
                    y: 8
                    width: 106
                    height: 28
                    text: "load file"
                    onClicked: {
                        filedialog.open()
                        webview.runJavaScript("setposition(43.022188, 141.463268)")
                    }
                }
            }

        }


    }

}
