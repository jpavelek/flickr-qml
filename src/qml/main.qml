import QtQuick 1.1
import com.nokia.meego 1.0
import QtWebKit 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    Page {
        id: mainPage
        tools: commonTools

        ToolBarLayout {
            id: commonTools
            visible: true

            ToolIcon {
                id: addButton
                iconSource: "qrc:/data/icon-m-add-application.svg"
                onClicked: {
                    addWebApp.open()
                }
            }


            ToolIcon {
                id: menuButton
                iconId: "toolbar-view-menu"
                onClicked: (mapsMenu.status == DialogStatus.Closed) ? mapsMenu.open() : mapsMenu.close()
            }

        }

        Menu {
            id: mapsMenu
            MenuLayout {
                MenuItem { text: "Exit"; onClicked: Qt.quit() }
            }
        }

        WebView {
            id: webView
            anchors.fill: parent
            url: gotoUri  //value/property passed from main.cpp
        }


        Sheet {
            id: addWebApp
            acceptButtonText: "Save"
            rejectButtonText: "Cancel"

            content: Flickable {
                anchors.fill: parent; anchors.leftMargin: 20; anchors.rightMargin:20; anchors.topMargin:50
                flickableDirection: Flickable.VerticalFlick

                Column {
                    spacing: 30
                    anchors.fill: parent; anchors.leftMargin: 20; anchors.rightMargin: 20

                    Text {
                        text: "Application Icon"; font.bold: true; font.pixelSize: 32; anchors.horizontalCenter: parent.horizontalCenter;
                    }
                    Image {
                        source: "qrc:/data/icons-Applications-html5.svg"; anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Application Name"; font.bold: true; font.pixelSize: 32; anchors.horizontalCenter: parent.horizontalCenter
                    }
                    TextField {
                        id: addWebAppNameField
                        text: "HTML5 App"
                        anchors.horizontalCenter: parent.horizontalCenter; anchors.left: parent.left; anchors.right: parent.right
                    }
                    Text {
                        text: "URL"; font.bold: true; font.pixelSize: 32; anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: webView.url; anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
            onAccepted: {
                console.log("Creating new app launcher with URL " + webView.url + " and name " + addWebAppNameField.text)
                //TODO - create desktop file in home, not is /usr/share/applications/
            }
        }
    }
}


