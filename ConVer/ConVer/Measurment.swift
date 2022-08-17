//
//  Measurment.swift
//  ConVer
//
//  Created by Calum Haddow on 27/07/2022.
//

import Foundation


struct Length {
    
    static let m = Measure(name: "m", measurement: UnitLength.meters)
    static let km = Measure(name: "km", measurement: UnitLength.kilometers)
    static let ft = Measure(name: "ft", measurement: UnitLength.feet)
    static let yrds = Measure(name: "yrds", measurement: UnitLength.yards)
    static let mi = Measure(name: "mi", measurement: UnitLength.miles)
    
    
    static let array = [m, km, ft, yrds, mi]
    
}
