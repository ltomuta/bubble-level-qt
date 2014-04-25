# Copyright (c) 2011-2014 Microsoft Mobile.

QT       += declarative
CONFIG   += mobility
MOBILITY += sensors

TARGET = qtbubblelevel
TEMPLATE = app

VERSION = 1.3.1

HEADERS += taskswitcher.h \
           accelerometerfilter.h \
           settings.h

SOURCES += main.cpp \
           taskswitcher.cpp \
           accelerometerfilter.cpp

OTHER_FILES += qml/*.qml \
               qml/images/*.png

RESOURCES = resources.qrc

symbian {
    TARGET = QtBubbleLevel

    # To lock the application to landscape orientation
    LIBS += -lcone -leikcore -lavkon

    ICON = icons/bubblelevel.svg
}

# Maemo 5 and Harmattan
unix:!symbian {
    # Common
    BINDIR = /opt/usr/bin
    DATADIR = /usr/share

    DEFINES += \
        DATADIR=\\\"$$DATADIR\\\" \
        PKGDATADIR=\\\"$$PKGDATADIR\\\"

    target.path = $$BINDIR

    iconxpm.path = $$DATADIR/pixmap
    iconxpm.files += icons/xpm/qtbubblelevel.xpm

    icon26.path = $$DATADIR/icons/hicolor/26x26/apps
    icon26.files += icons/26x26/qtbubblelevel.png

    icon40.path = $$DATADIR/icons/hicolor/40x40/apps
    icon40.files += icons/40x40/qtbubblelevel.png

    icon64.path = $$DATADIR/icons/hicolor/64x64/apps
    icon64.files += icons/64x64/qtbubblelevel.png

    maemo5 {
        # Maemo 5 spesific
        desktop.path = $$DATADIR/applications/hildon
        desktop.files += qtc_packaging/debian_fremantle/$${TARGET}.desktop
    }
    else {
        # Harmattan specific
        DEFINES += Q_WS_MAEMO_6

        desktop.path = $$DATADIR/applications
        desktop.files = qtc_packaging/debian_harmattan/$${TARGET}.desktop
    }

    INSTALLS += \
        target \
        desktop \
        iconxpm \
        icon26 \
        icon40 \
        icon64
}

# Linux desktop
#unix:!symbian:!maemo5 {
#    target.path = /opt/qtbubblelevel/bin
#    INSTALLS += target
#}
