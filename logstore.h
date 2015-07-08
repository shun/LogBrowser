#ifndef LOGSTORE_H
#define LOGSTORE_H

#include <QObject>

class LogStore : public QObject
{
    Q_OBJECT
public:
    LogStore(QObject *parent = 0);
    Q_INVOKABLE void loadfile(QString path);
    Q_INVOKABLE QStringList getLogs() {return m_datalist;}

signals:

public slots:

private:
    QString m_filepath;
    QStringList m_datalist;
};

#endif // LOGSTORE_H
