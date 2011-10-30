import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow
    initialPage: thumbnailPage

    ThumbnailPage {
        id: thumbnailPage

        anchors { fill: parent; }
        inPortrait: appWindow.inPortrait
        model: PhotoFeedModel {
            id: photoFeedModel
        }
        tools: commonTools

        ToolBarLayout {
            id: commonTools
            visible: true

            ToolIcon {
                id: backButton
                iconId: "toolbar-back"
                onClicked: pageStack.pop
            }
            ToolIcon {
                id: addButton
                iconId: "icon-m-toolbar-refresh"
                onClicked: { console.log("Refresh")}
            }
            ToolIcon {
                id: menuButton
                iconId: "toolbar-view-menu"
                onClicked: (mainMenu.status == DialogStatus.Closed) ? mainMenu.open() : mainMenu.close()
            }
        }
        onPhotoClicked: {
            largeImagePage.setPhotoData(url, photoWidth, photoHeight);
            detailsPage.setPhotoData(author, date, description, tags, title,
                                     photoWidth, photoHeight);
            pageStack.push(largeImagePage);
        }

        Menu {
            id: mainMenu
            MenuLayout {
                MenuItem { text: "Exit"; onClicked: Qt.quit() }
            }
        }   
    }
}


