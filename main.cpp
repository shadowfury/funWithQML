#include <qt4/QtGui/QApplication>
//#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "cursorshapearea.h"
#include "blockschaltbild.h"
#include <QObject>
#include <QtDeclarative>
#include <QGraphicsObject>
#include <QPixmap>


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));




    Blockschaltbild bild;
    qmlRegisterType<QsltCursorShapeArea>("Cursor", 1, 0, "CursorShapeArea");


    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/moonkin/main.qml"));
    QObject *object = viewer.rootObject();
    QObject::connect(object, SIGNAL(testSig()), &bild, SLOT(BlockSlot()));
    viewer.showExpanded();



    //scaledToWidth(20);
    viewer.setCursor(QPixmap(":/images/peach.png").scaledToWidth(20));

    return app->exec();
}
