/*
 * Copyright (c) 2011 Nokia Corporation.
 */

#ifndef TASKSWITCHER_H
#define TASKSWITCHER_H

#include <QObject>

class TaskSwitcher : public QObject
{
    Q_OBJECT

public slots:
    void minimizeApplication();
};

#endif // TASKSWITCHER_H
