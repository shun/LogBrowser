#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QtWebEngine>
#include "logstore.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QtWebEngine::initialize();
    LogStore store;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("logstore", &store);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
