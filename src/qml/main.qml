import QtQuick 1.1
import com.nokia.meego 1.0

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
                onClicked: (mainMenu.status == DialogStatus.Closed) ? mainMenu.open() : mainMenu.close()
            }

        }

        Menu {
            id: mainMenu
            MenuLayout {
                MenuItem { text: "Exit"; onClicked: Qt.quit() }
            }
        }   
    }
}


