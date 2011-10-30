#include <QtGui/QApplication>
#include <QtDeclarative>


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication *app = new QApplication(argc, argv);

    app->setProperty("NoMStyle", true);
    QDeclarativeView *view = new QDeclarativeView();

#ifdef __arm__
    view->showFullScreen();
#else
    view->show();
#endif

    QObject::connect(view->engine(), SIGNAL(quit()), view, SLOT(close()));

    return app->exec();
}
