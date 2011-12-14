contains(MEEGO_EDITION,harmattan) {
  CONFIG += qt-boostable qdeclarative-boostable
  LIBS += -lmdeclarativecache
  INCLUDEPATH += /usr/include/applauncherd
}

icon.files = src/data/icons-Applications-flickr.png
icon.path = /usr/share/themes/base/meegotouch/icons/
DEPLOYMENT += icon

desktop.files = src/data/flickr-qml.desktop
desktop.path = /usr/share/applications/
DEPLOYMENT += desktop

splash.files = src/data/flickr-qml-splash-p-800x480.png
splash.path = /usr/share/pixmaps/
DEPLOYMENT += splash

QT+= declarative
TEMPLATE = app
TARGET = flickr-qml
DESTDIR = bin

include(src/src.pri)

include(deployment.pri)
qtcAddDeployment()
