#include <QtGui/QApplication>
#include <QtDeclarative>
#include "imagesaver.h"



Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication *app = new QApplication(argc, argv);

    app->setProperty("NoMStyle", true);
    QDeclarativeView *view = new QDeclarativeView();
    view->setSource(QUrl("qrc:/qml/main.qml"));

#ifdef __arm__
    view->showFullScreen();
#else
    view->show();
#endif

    QObject::connect(view->engine(), SIGNAL(quit()), view, SLOT(close()));

    ImageSaver imageSaver;
    view->rootContext()->setContextProperty("imageSaver", &imageSaver);


    return app->exec();
}
