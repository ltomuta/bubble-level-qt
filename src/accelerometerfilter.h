/*
 * Copyright (c) 2011 Nokia Corporation.
 */

#ifndef ACCELEROMETERFILTER_H
#define ACCELEROMETERFILTER_H

//! [0]
#include <QAccelerometerFilter>
#include <QVariant>

QTM_USE_NAMESPACE

class AccelerometerFilter
    : public QObject, public QAccelerometerFilter
{
    Q_OBJECT

protected:
    qreal x;
    qreal y;
    qreal z;

public:
    AccelerometerFilter();
    bool filter(QAccelerometerReading *reading);

signals:
    void rotationChanged(const QVariant &deg);
};
//! [0]

#endif // ACCELEROMETERFILTER_H
