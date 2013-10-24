/*
 * Copyright (c) 2011 Nokia Corporation.
 */

import QtQuick 1.0

//! [0]
Item {
    id: tube

    property real deg

    Image {
        id: bubble

        property real center: tube.width / 2
        property real bubbleCenter: bubble.width / 2

        function calX() {
            var newX = center + tube.deg / -20 * center

            if ((newX - bubbleCenter) < 0) {
                return 0
            }
            else if((newX + bubbleCenter) > tube.width) {
                return tube.width - 2 * bubbleCenter
            }

            return newX - bubbleCenter;
        }

        x: calX()
        width: 0.16129032 * parent.width; height: 0.66666667 * parent.height
        source: "images/bubble.png"
        smooth: true
    }

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 0.36451613 * parent.width; height: 0.66666667 * parent.height
        source: "images/scale.png"
    }

    Image {
        width: parent.width; height:  0.32 * parent.height
        opacity: 0.8
        source: "images/reflection.png"
    }
}
//! [0]
