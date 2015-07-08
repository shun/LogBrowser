#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QtWebEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QtWebEngine::initialize();
    QStringList datalist;

    for (int i = 0; i < 40; i++) {
        datalist.append(QString::asprintf("item %d", i));
    }

//    QQuickView view;
//    QQmlContext *context = view.rootContext();
//    context->setContextProperty("dataset", QVariant::fromValue(datalist));
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("dataset", QVariant::fromValue(datalist));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    view.setSource(QUrl("qrc:main.qml"));
//    view.show();
    return app.exec();
}
