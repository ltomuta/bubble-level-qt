/*
 * Copyright (c) 2011 Nokia Corporation.
 */

#ifndef SETTINGS_H
#define SETTINGS_H

#include <QtCore>

class Settings : public QObject
{
    Q_OBJECT

public:
    void loadAndEmitCorrectionAngle() {
        QSettings settings("Nokia corp", "QtBubbleLevel");
        emit correctionAngle(settings.value("CorrectionAngle", "0.0f"));
    }

signals:
    void correctionAngle(const QVariant &angle);

public slots:
    void saveCorrectionAngle(const QVariant &angle) {
        QSettings settings("Nokia corp", "QtBubbleLevel");
        settings.setValue("CorrectionAngle", angle);
    }
};

#endif // SETTINGS_H
