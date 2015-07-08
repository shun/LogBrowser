#include <fstream>
#include "logstore.h"
#include <QDebug>
#include <iostream>

using namespace std;

LogStore::LogStore(QObject *parent) : QObject(parent)
{

}

void LogStore::loadfile(QString path)
{
    path.remove(0, 8);  // "file:///"の部分を削除
    ifstream ifs(path.toStdString());
    string line;
    QString lat, lng;
    QString str;
    QStringList items;
    lat = "";
    lng = "";

    m_datalist.clear();

    while(getline(ifs, line))
    {
        str = QString::fromStdString(line);
        items = str.split(',');
        if ((lat.compare(items[2]) != 0) || (lng.compare(items[3])))
        {
            lat = items[2];
            lng = items[3];
            m_datalist.append(str);
        }
    }
}
