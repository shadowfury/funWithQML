#ifndef BLOCKSCHALTBILD_H
#define BLOCKSCHALTBILD_H
#include <QDebug>

class Blockschaltbild: public QObject
{
    Q_OBJECT
public slots:
    void BlockSlot(){
        //qDebug() << "Slot is working";
    }
public:
};

#endif // BLOCKSCHALTBILD_H
