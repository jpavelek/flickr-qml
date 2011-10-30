QT+= declarative
TEMPLATE = app
TARGET = flickr-qml
DESTDIR = bin

include(src/src.pri)

include(deployment.pri)
qtcAddDeployment()
