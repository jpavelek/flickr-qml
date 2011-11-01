#include "imagesaver.h"
#include <QtGui/QApplication>
#include <QtDeclarative>

ImageSaver::ImageSaver(QObject *parent) : QObject(parent)
{
    //do nothing here
}


void ImageSaver::save(QObject *imageObj, const QString &url)
{
    QGraphicsObject *item = qobject_cast<QGraphicsObject*>(imageObj);

    if (!item) {
        qDebug() << "Item is NULL";
        return;
    }

    QImage img(item->boundingRect().size().toSize(), QImage::Format_RGB32);
    img.fill(QColor(255, 255, 255).rgb());
    QPainter painter(&img);
    QStyleOptionGraphicsItem styleOption;
    item->paint(&painter, &styleOption);
    QStringList pathParts = url.split("/");
    //qDebug("Got %d count and last one is %s", pathParts.count(), pathParts.at(pathParts.count()).toLatin1());
    QString path = pathParts.last().prepend("/MyDocs/Pictures/").prepend(getenv("HOME"));
    img.save(path);
}
