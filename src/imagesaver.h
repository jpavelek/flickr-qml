#ifndef IMAGESAVER_H
#define IMAGESAVER_H

#include <QObject>

class ImageSaver : public QObject
{
    Q_OBJECT
public:
    explicit ImageSaver(QObject *parent = 0);

signals:

public slots:
    void save(QObject *item, const QString &url);
};

#endif // IMAGESAVER_H
