/**
 * Copyright (c) 2011-2014 Microsoft Mobile.
 */

#include <QtDeclarative>
#include <QtGui>
#include <QAccelerometer>

#include "accelerometerfilter.h"
#include "settings.h"
#include "taskswitcher.h"

// Lock orientation in Symbian
#ifdef Q_OS_SYMBIAN
    #include <eikenv.h>
    #include <eikappui.h>
    #include <aknenv.h>
    #include <aknappui.h>
#endif

QTM_USE_NAMESPACE


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

#ifdef Q_OS_SYMBIAN
    // Lock orientation to landscape in Symbian.
    CAknAppUi* appUi = dynamic_cast<CAknAppUi*> (CEikonEnv::Static()->AppUi());
    TRAP_IGNORE(
        if (appUi)
            appUi->SetOrientationL(CAknAppUi::EAppUiOrientationLandscape);
    )
#endif

    //! [0]
    QDeclarativeView view;  
    view.setSource(QUrl("qrc:/qml/BubbleLevel.qml"));
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    //! [0]

    //! [1]
    Settings settings;

    QAccelerometer sensor;

#ifdef Q_WS_MAEMO_6
    // The data rate of the accelerometer sensor is around 1 Hz by default.
    // The reason for this is to save power if more frequent rate is not
    // required. Thus, we need to change the rate explicitly.
    sensor.setDataRate(50); // Hz
#endif

    AccelerometerFilter filter;
    sensor.addFilter(&filter);
    //! [1]

    //! [2]
    QObject *rootObject = dynamic_cast<QObject*>(view.rootObject());

    // Associate Qt / QML signals and slots
    QObject::connect(rootObject, SIGNAL(saveCorrectionAngle(const QVariant&)),
                     &settings, SLOT(saveCorrectionAngle(const QVariant&)));

    QObject::connect(&filter, SIGNAL(rotationChanged(const QVariant&)),
                     rootObject, SLOT(handleRotation(const QVariant&)));

    QObject::connect(&settings, SIGNAL(correctionAngle(const QVariant&)),
                     rootObject, SLOT(setCorrectionAngle(const QVariant&)));

    QObject::connect((QObject*)view.engine(), SIGNAL(quit()),
                     &app, SLOT(quit()));
    //! [2]

    //! [3]
#ifdef Q_WS_MAEMO_5
    TaskSwitcher taskSwitcher;

    QObject::connect(rootObject, SIGNAL(minimizeApplication()),
                     &taskSwitcher, SLOT(minimizeApplication()));

    // Show the task switcher button
    rootObject->setProperty("taskSwitcherVisible", true);
#endif
    //! [3]

#ifdef Q_WS_MAEMO_6
    // No exit button in Harmattan.
    rootObject->setProperty("exitButtonVisible", false);
#endif

    //! [4]
    // Read correction factor from permanent storage and emit it to QML side
    settings.loadAndEmitCorrectionAngle();

    // Begin measuring of the accelerometer sensor
    sensor.start();
    //! [4]

    //! [5]
#if defined(Q_WS_MAEMO_6) || defined(Q_WS_MAEMO_5) || \
    defined(Q_OS_SYMBIAN) || defined(Q_WS_SIMULATOR)
    view.setGeometry(QApplication::desktop()->screenGeometry());
    view.showFullScreen();
#else
    view.setGeometry((QRect(100, 100, 800, 480)));
    view.show();
#endif
    //! [5]

    return app.exec();
}
