/*
 * Copyright (c) 2011-2014 Microsoft Mobile.
 */

#include "accelerometerfilter.h"
#include <math.h>

#define RADIANS_TO_DEGREES 57.2957795

AccelerometerFilter::AccelerometerFilter()
    : x(0), y(0), z(0)
{
}

//! [0]
bool AccelerometerFilter::filter(QAccelerometerReading *reading)
{
    qreal rx = reading->x();
    qreal ry = reading->y();
    qreal rz = reading->z();

    qreal divider = sqrt(rx * rx + ry * ry + rz * rz);

    // Lowpass factor
#if defined(Q_WS_MAEMO_6) || defined(Q_OS_SYMBIAN)
    float lowPassFactor = 0.10;
#else
    float lowPassFactor = 0.05;
#endif

    // Calculate the axis angles in degrees and reduce the noise in sensor
    // readings.
    x += (acos(rx / divider) * RADIANS_TO_DEGREES - 90 - x) * lowPassFactor;
    y += (acos(ry / divider) * RADIANS_TO_DEGREES - 90 - y) * lowPassFactor;
    z += (acos(rz / divider) * RADIANS_TO_DEGREES - 90 - z) * lowPassFactor;

    // The orientations of the accelerometers are different between
    // Symbian and Maemo devices so we use different axis
    // depending on the platform.
#if defined(Q_WS_MAEMO_6) || defined(Q_OS_SYMBIAN)
    emit rotationChanged(-y);
#else
    emit rotationChanged(x);
#endif

    // Don't store the reading in the sensor.
    return false;
}
//! [0]
