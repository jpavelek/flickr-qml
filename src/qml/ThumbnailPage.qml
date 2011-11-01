/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from tdhis software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0
import com.nokia.meego 1.0
import "UIConstants.js" as UI

FlickrPage {
    id: thumbnailPage

    property XmlListModel model
    property bool inPortrait

    signal photoClicked(string url, int photoWidth, int photoHeight, string author, string date, string description, string tags, string title)
    Keys.forwardTo: [(keyCapture), (searchTags)]

    function accept() {
        photoFeedModel.tags = searchTags.text
        searchTags.focus = false
        searchTags.platformCloseSoftwareInputPanel()
        searchButton.focus = true
    }

    GridView {
        id: gridComponent
        anchors { top: blackFill.bottom; left:parent.left;right:parent.right; bottom: parent.bottom }
        property int thumbnailsInRow: 4

        function cellWidth() {
            return Math.floor(width / thumbnailsInRow);
        }

        cacheBuffer: 2 * height
        cellHeight: cellWidth
        cellWidth: cellWidth()
        delegate: GridDelegate {
            onPhotoClicked: {
                thumbnailPage.photoClicked(url, photoWidth, photoHeight, author, date, description, tags, title);
            }
        }
        model: thumbnailPage.model

        onWidthChanged: {
            thumbnailsInRow = width / (UI.THUMBNAIL_WRAPPER_SIDE + UI.THUMBNAIL_SPACING);
        }
    }

    Rectangle {
        id: blackFill
        color: "black"
        anchors { left: parent.left; right: parent.right; top: parent.top }
        height: searchTags.height + UI.SEARCH_TOP_MARGIN + UI.SEARCH_BOTTOM_MARGIN
    }

    TextField {
        id: searchTags
        anchors { top:parent.top; left: parent.left; right:parent.right; topMargin: UI.SEARCH_TOP_MARGIN; bottomMargin: UI.SEARCH_BOTTOM_MARGIN }
        placeholderText: "Enter search tags"
        platformStyle: TextFieldStyle { paddingRight: searchButton.width + 2*UI.SEARCH_PADDING_RIGHT ; paddingLeft:searchButton.width + 2*UI.SEARCH_PADDING_RIGHT  }
        platformSipAttributes: SipAttributes { actionKeyHighlighted: true; actionKeyEnabled: true }

        Image {
            id: searchButton
            anchors { verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: UI.SEARCH_PADDING_RIGHT }
            smooth: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/data/searchbar-search-tags.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    photoFeedModel.tags = searchTags.text
                    searchTags.platformCloseSoftwareInputPanel()
                }
            }
        }
        Image {
            id: clearButton
            anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: UI.SEARCH_PADDING_RIGHT }
            smooth: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/data/searchbar-clear-tags.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    photoFeedModel.tags = searchTags.text
                    searchTags.text = ""
                }
            }
        }
    }
    Item { //This is one ugly hack for the VKB, but works ...
        id: keyCapture

        Keys.onReturnPressed: accept();
        Keys.onEnterPressed:  accept();
    }

}

