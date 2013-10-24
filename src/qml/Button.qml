/*
 * Copyright (c) 2011 Nokia Corporation.
 */

import QtQuick 1.0

Rectangle {
    id: button

    property alias source: image.source
    property alias mouseAreaScale: mouseArea.scale

    signal clicked

    width: 50; height: 50
    color: "transparent"

    Behavior on scale { NumberAnimation { duration: 50 } }

    Image {
        id: image

        anchors.fill: parent
        smooth: true
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: { button.clicked() }
        onEntered: { button.scale = 0.9 }
        onExited: { button.scale = 1.0 }
    }
}
