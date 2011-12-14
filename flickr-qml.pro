contains(MEEGO_EDITION,harmattan) {
  CONFIG += qt-boostable qdeclarative-boostable
  LIBS += -lmdeclarativecache
  INCLUDEPATH += /usr/include/applauncherd
}

myicon.files = ./src/data/icons-Applications-flickr.png
myicon.path = /usr/share/themes/base/meegotouch/icons/
INSTALLS += myicon

mysplash.files = ./src/data/flickr-qml-splash-p-800x480.png
mysplash.path = /usr/share/pixmaps/
INSTALLS += mysplash

QT+= declarative
TEMPLATE = app
TARGET = flickr-qml
DESTDIR = bin

include(src/src.pri)

include(deployment.pri)
qtcAddDeployment()
