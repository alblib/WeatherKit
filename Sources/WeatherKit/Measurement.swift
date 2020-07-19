//
//  Measurement.swift
//  
//
//  Created by Albertus Liberius on 2020/07/19.
//

/*
*  Copyright (c) Albertus Libertus 2020
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import Foundation
import CoreLocation

typealias Pressure = Measurement<UnitPressure>
typealias Temperature = Measurement<UnitTemperature>
typealias Speed = Measurement<UnitSpeed>
typealias Angle = Measurement<UnitAngle>

extension Measurement where UnitType == UnitPressure{
    init(hectopascals: Double){
        self.init(value: hectopascals, unit: .hectopascals)
    }
    init(inchesOfMercury: Double){
        self.init(value: inchesOfMercury, unit: .inchesOfMercury)
    }
    var hectopascals: Double{
        self.converted(to: .hectopascals).value
    }
    var inchesOfMercury: Double{
        self.converted(to: .inchesOfMercury).value
    }
    /** Hundreds of feet converted by International Standard Atmosphere under 20km. Not correct above that. */
    var flightLevel: Double{
        if hPa > 226.321{
            return (1 - pow(hPa/1013.25, 1/5.255876113278518)) / (0.0065/288.15) / 0.3048 / 100
        }else{
            return (11000 - log(hPa/226.321) / 0.00015768841327629983) / 0.3048 / 100
        }
    }
}

extension Measurement where UnitType == UnitTemperature{
    init(kelvin: Double){
        self.init(value: kelvin, unit: .kelvin)
    }
    init(celsius: Double){
        self.init(value: celsius, unit: .celsius)
    }
    init(fahrenheit: Double){
        self.init(value: fahrenheit, unit: .fahrenheit)
    }
    var kelvin: Double{
        self.converted(to: .kelvin).value
    }
    var celsius: Double{
        self.converted(to: .celsius).value
    }
    var fahrenheit: Double{
        self.converted(to: .fahrenheit).value
    }
}

extension Measurement where UnitType == UnitSpeed{
    init(metersPerSecond: Double){
        self.init(value: metersPerSecond, unit: .metersPerSecond)
    }
    init(milesPerHour: Double){
        self.init(value: milesPerHour, unit: .milesPerHour)
    }
    init(kilometersPerHour: Double){
        self.init(value: kilometersPerHour, unit: .kilometersPerHour)
    }
    init(knots: Double){
        self.init(value: knots, unit: .knots)
    }
    var metersPerSecond: Double{
        self.converted(to: .metersPerSecond).value
    }
    var milesPerHour: Double{
        self.converted(to: .milesPerHour).value
    }
    var kilometersPerHour: Double{
        self.converted(to: .kilometersPerHour).value
    }
    var knots: Double{
        self.converted(to: .knots).value
    }
}

extension Measurement where UnitType == UnitAngle{
    init(degrees: Double){
        self.init(value: degrees, unit: .degrees)
    }
}

struct GroundVelocity{
    var azimuth: Angle
    var speed: Speed
    
    init(azimuth: Double, metersPerSecond: Double){
        self.azimuth = Angle(degrees: azimuth)
        self.speed = Speed(metersPerSecond: metersPerSecond)
    }
    init(azimuth: Double, speed: Speed){
        self.azimuth = Angle(degrees: azimuth)
        self.speed = speed
    }
    init(azimuth: Angle, speed: Speed){
        self.azimuth = azimuth
        self.speed = speed
    }
    init?(location: CLLocation){
        if location.course < 0{
            return nil
        }else{
            self.init(azimuth: location.course, metersPerSecond: location.speed)
        }
    }
}

extension Measurement where UnitType == UnitLength{
    init(meters: Double){
        self.init(value: meters, unit: .meters)
    }
    init(kilometers: Double){
        self.init(value: kilometers, unit: .kilometers)
    }
    init(feet: Double){
        self.init(value: feet, unit: .feet)
    }
    init(hundredsOfFeet: Double){
        self.init(value: hundredsOfFeet * 100, unit: .feet)
    }
    var meters: Double{
        self.converted(to: .meters).value
    }
    var kilometers: Double{
        self.converted(to: .kilometers).value
    }
    var feet: Double{
        self.converted(to: .feet).value
    }
    
}
