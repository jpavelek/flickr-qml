import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow
    initialPage: thumbnailPage

    ThumbnailPage {
        id: thumbnailPage

        anchors.fill: parent
        inPortrait: appWindow.inPortrait
        model: PhotoFeedModel {
            id: photoFeedModel
        }

        tools: commonTools

        ToolBarLayout {
            id: commonTools
            visible: true

            ToolIcon {
                id: refreshButton
                iconId: "icon-m-toolbar-refresh"
                onClicked: { photoFeedModel.reload() }
            }
            BusyIndicator {
                platformStyle: BusyIndicatorStyle { size: "medium" }
                running: photoFeedModel.progress != 1
                visible: photoFeedModel.progress != 1
            }

            ToolIcon {
                id: menuButton
                iconId: "toolbar-view-menu"
                onClicked: (mainMenu.status == DialogStatus.Closed) ? mainMenu.open() : mainMenu.close()
            }
        }
        onPhotoClicked: {
            imageDetails.setPhotoData(url, photoWidth, photoHeight);
            pageStack.push(imageDetails);
        }

        Menu {
            id: mainMenu
            MenuLayout {
                MenuItem { text: "Exit"; onClicked: Qt.quit() }
            }
        }   
    }

    ImageDetails {
        id:imageDetails
    }
}


