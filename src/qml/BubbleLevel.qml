/*
 * Copyright (c) 2011 Nokia Corporation.
 */

import QtQuick 1.0

Image {
    id: bubbleLevel

    //! [0]
    // Signaled when task switcher button is pressed
    signal minimizeApplication()

    // Signaled when correction angle is saved
    signal saveCorrectionAngle(variant angle)

    // These functions are used as Qt slots
    function handleRotation(deg) {
        horTube.rawangle = deg
    }

    function setCorrectionAngle(deg) {
        horTube.angleconstant = deg
    }

    // Used to show the task switcher button in Maemo targets
    property alias taskSwitcherVisible: taskSwitcher.visible
    //! [0]

    // No exit button in Harmattan style.
    property alias exitButtonVisible: exitButton.visible

    anchors.fill: parent
    source: "images/board.png"
    smooth: true

    MouseArea {
        anchors.fill: parent
        onClicked: sign.frontSide = true
    }

    Button {
        id: taskSwitcher

        anchors {
            left: parent.left
            right: horTube.left
            verticalCenter: horTube.verticalCenter
            margins: (parent.width - (horTube.x + horTube.width)) / 4
        }

        height: width
        source: "images/taskswitcher.png"
        mouseAreaScale: 2
        onClicked: bubbleLevel.minimizeApplication()
        visible: false
    }

    Button {
        id: exitButton

        anchors {
            left: horTube.right
            right: parent.right
            verticalCenter: horTube.verticalCenter
            margins: (parent.width - (horTube.x + horTube.width)) / 4
        }

        height: width
        source: "images/exit.png"
        mouseAreaScale: 2
        onClicked: Qt.quit()
    }

    //! [1]
    Tube {
        id: horTube

        property real rawangle: 0
        property real angleconstant: 0

        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.775; height: parent.height * 0.15625
        deg: rawangle - angleconstant
    }
    //! [1]

    Flipable {
        id: sign

        property bool frontSide: true

        x: parent.width * 0.185; y: parent.height * 0.669
        width: parent.width * 0.63; height: parent.height * 0.258

        MouseArea {
            anchors.fill: parent
            onClicked: sign.frontSide = !sign.frontSide
            z: -1
        }

        transform: Rotation {

            origin.x: sign.width / 2; origin.y: sign.height / 2
            axis.x: 1; axis.y: 0; axis.z: 0
            angle: sign.frontSide ? 0 : 180

            Behavior on angle {
                RotationAnimation {
                    direction: RotationAnimation.Clockwise
                    easing.type: Easing.InOutCubic; duration: 300
                }
            }
        }

        front: Image {
            anchors.fill: parent
            source: "images/signwithtext.png"
            smooth: true
        }

        back: Image {
            anchors.fill: parent
            source: "images/signblank.png"
            smooth: true

            Text {
                id: oldValue

                anchors {
                    left: parent.left; leftMargin: parent.width * 0.10
                    right: saveButton.left; rightMargin: 10
                    verticalCenter: parent.verticalCenter
                }

                text: "Place the device on a level surface and tap Calibrate."
                color: "#302020"
                wrapMode: Text.WordWrap
                font {
                    bold: false
                    pixelSize: Math.min(parent.width, parent.height) * 0.19
                }
            }

            Button {
                id: saveButton

                anchors {
                    right: parent.right; rightMargin: parent.width * 0.09
                    verticalCenter: parent.verticalCenter
                }

                width: parent.width * 0.25; height: parent.height * 0.65
                border { width: 2; color: "#555555" }
                radius: 10

                onClicked: {
                    horTube.angleconstant = horTube.rawangle
                    saveCorrectionAngle(horTube.angleconstant)
                }

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#999999" }
                    GradientStop { position: 0.2; color: "#BBBBBB" }
                    GradientStop { position: 0.8; color: "#BBBBBB" }
                    GradientStop { position: 1.0; color: "#999999" }
                }

                Text {
                    anchors.centerIn: parent
                    color: "#302020"
                    text: "Calibrate"
                    font { bold: true; pixelSize: parent.width * 0.15 }
                    smooth: true
                }
            }
        }
    }

    Button {
        anchors {
            left: sign.right
            right: parent.right
            verticalCenter: sign.verticalCenter
            margins: (parent.width - (sign.x + sign.width)) / 4
        }

        height: width
        source: "images/calibbutton.png"
        mouseAreaScale: 2
        smooth: true

        onClicked: sign.frontSide = !sign.frontSide
    }
}
