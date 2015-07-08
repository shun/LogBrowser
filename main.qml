import QtQuick 2.5
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
            Text { text: line; font.family: "ＭＳ ゴシック"}
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
            visible = false
            logstore.loadfile(filedialog.fileUrl)
            listmodel.clear()
            var lines = logstore.getLogs()
            var i = 0
            var items
            var func = ""
            var splat = ""
            var splng = ""
            var edlat = ""
            var edlng = ""

            for (i = 0; i < lines.length; i++)
            {
                listmodel.append({"line": lines[i]})
                items = lines[i].split(",")

                if (items[0] !== "Time")
                {
                    func = "drawcircle(" + items[2] + "," + items[3] + "," + items[5] + ")"
                    webview.runJavaScript(func)

                    if (splat.length == 0)
                    {
                        splat = items[2]
                        splng = items[3]
                    }
                    else
                    {
                        edlat = items[2]
                        edlng = items[3]
                        func = "drawline(" + splat + "," + splng + "," + edlat + "," + edlng + ")"
                        webview.runJavaScript(func)
                        splat = edlat
                        splng = edlng
                    }
                }
            }
        }

        onRejected: {
            visible = false
        }
    }

    ListModel {
        id:listmodel
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

        WebEngineView {
            id: webview
            url: "default.html"
            height: root.height / 2

            onFocusChanged: {
                focus = false
                list.focus = true
            }
        }

        Rectangle {
            ListView {
                id: list
                model:listmodel
                clip: true


                width:root.width / 4 * 3
                height: root.height / 2
                x:0
                focus:true
                highlightMoveDuration: 0
                highlightResizeDuration:0
                highlight: Rectangle {color:"lightsteelblue"; radius:5}

                delegate: itemDelegate

                onCurrentIndexChanged: {
                    var line = listmodel.get(list.currentIndex).line
                    var items = line.split(",")
                    var func = "setmaker(" + items[2] + "," + items[3] + ")"
                    webview.runJavaScript(func)
                }
                Keys.onPressed: {
                    if (event.key == Qt.Key_PageUp) {
                        list.currentIndex -= 10
                    }
                    else if (event.key == Qt.Key_PageDown) {
                        list.currentIndex += 10
                    }
                }
            }


            Rectangle {
                id: ctrlpane
                width:root.width / 4
                color:"lightgray"
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
                    }
                }
            }

        }

    }

}
