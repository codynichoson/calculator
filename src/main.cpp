#include <QGuiApplication>
#include <QQmlContext>
#include <QQuickView>

#include "calculator_backend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    CalculatorBackend backend;

    QQuickView view;
    view.rootContext()->setContextProperty("calculator", &backend);
    view.setSource(QUrl("qml/main.qml"));
    view.show();

    return app.exec();
}
