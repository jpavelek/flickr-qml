import QtQuick 1.0
import com.nokia.meego 1.0
import "UIConstants.js" as UI

FlickrPage {
    id: imageDetails
    tools: detailsTools

    property string photoUrl
    property int photoHeight
    property int photoWidth

    function setPhotoData(url, photoWidth, photoHeight) {
        imageDetails.photoUrl = url;
        imageDetails.photoHeight = photoHeight;
        imageDetails.photoWidth = photoWidth;
    }

    BusyIndicator {
        id: imageLoadingProgress
        platformStyle: BusyIndicatorStyle { size: "large" }
        running: image.status != Image.Ready
        visible: image.status != Image.Ready
        anchors.centerIn: parent
    }

    Flickable {
        id: flickable

        anchors.fill: parent
        clip: true
        contentWidth: imageContainer.width
        contentHeight: imageContainer.height

        Item {
            id: imageContainer

            width: Math.max(image.width * image.scale, flickable.width)
            height: Math.max(image.height * image.scale, flickable.height)

            Image {
                id: image

                property real prevScale

                anchors.centerIn: parent
                smooth: !flickable.movingVertically
                source: imageDetails.photoUrl

                sourceSize.width: (imageDetails.photoWidth > 1024
                                   && imageDetails.photoWidth > imageDetails.photoHeight) ? 1024 : 0
                sourceSize.height: (imageDetails.photoHeight > 1024
                                    && imageDetails.photoHeight > imageDetails.photoWidth) ? 1024 : 0

                onStatusChanged: {
                    if (status == Image.Loading) {
                        // Hide and reset slider: move slider handle to the left
                        slider.visible = false;
                        slider.value = 0;
                    } else if (status == Image.Ready && width != 0) {
                        // Default scale shows the entire image.
                        scale = Math.min(flickable.width / width, flickable.height / height);
                        prevScale = Math.min(scale, 1);

                        // Prepare and show the Slider if the image can be scaled
                        if (scale < 1) {
                            slider.minimumValue = scale;
                            slider.value = slider.minimumValue;
                            slider.visible = true;
                        }
                    }
                }

                onScaleChanged: {
                    if ((width * scale) > flickable.width) {
                        var xoff = (flickable.width / 2 + flickable.contentX) * scale / prevScale;
                        flickable.contentX = xoff - flickable.width / 2;
                    }
                    if ((height * scale) > flickable.height) {
                        var yoff = (flickable.height / 2 + flickable.contentY) * scale / prevScale;
                        flickable.contentY = yoff - flickable.height / 2;
                    }
                    prevScale = scale;
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }

    Text {
        text: qsTr("Image Unavailable")
        visible: image.status == Image.Error
        anchors.centerIn: parent
        color: UI.LARGEIMAGE_ERROR_MSG_COLOR
        font.bold: true
    }


    ToolBarLayout {
        id: detailsTools
        visible: true

        ToolIcon {
            id: detailsBackButton
            iconId: "toolbar-back"
            onClicked: {
                pageStack.pop()
            }
        }
        ToolIcon {
            id: detailsSaveButton
            iconSource: "qrc:/data/icon-m-toolbar-save-image.svg"
            onClicked: {
               console.log ("TODO - save this image on the device")
                //TODO
            }
        }

        ToolIcon {
            id: detailsMenuButton
            iconId: "toolbar-view-menu"
            onClicked: (mainMenu.status == DialogStatus.Closed) ? mainMenu.open() : mainMenu.close()
        }
    }

    Slider {
        id: slider

        maximumValue: 1
        stepSize: (maximumValue - minimumValue) / 100
        opacity: UI.SLIDER_OPACITY
        anchors {
            bottom: parent.bottom
            bottomMargin: UI.SLIDER_BOTTOM_MARGIN
            left: parent.left
            leftMargin: UI.SLIDER_SIDE_MARGIN
            right: parent.right
            rightMargin: UI.SLIDER_SIDE_MARGIN
        }
    }


    Binding { target: image; property: "scale"; value: slider.value; when: slider.visible }

}
