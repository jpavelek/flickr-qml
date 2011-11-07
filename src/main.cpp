#include <QtGui/QApplication>
#include <QtDeclarative>
#include "imagesaver.h"
#ifdef __arm__
#include <MDeclarativeCache>
#endif



Q_DECL_EXPORT int main(int argc, char *argv[])
{
#ifdef __arm__
    QApplication* app = MDeclarativeCache::qApplication(argc, argv);
    app->setProperty("NoMStyle", true);
    QDeclarativeView* view = MDeclarativeCache::qDeclarativeView();
    view->setSource(QUrl("qrc:/qml/main.qml"));
    view->showFullScreen();
#else
    QApplication *app = new QApplication(argc, argv);
    app->setProperty("NoMStyle", true);
    QDeclarativeView *view = new QDeclarativeView();
    view->setSource(QUrl("qrc:/qml/main.qml"));
    view->show();
#endif

    QObject::connect(view->engine(), SIGNAL(quit()), view, SLOT(close()));

    ImageSaver imageSaver;
    view->rootContext()->setContextProperty("imageSaver", &imageSaver);


    return app->exec();
}
