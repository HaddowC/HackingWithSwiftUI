//
//  Measurement.swift
//  ConVer
//
//  Created by Calum Haddow on 01/08/2022.
//

import Foundation


struct Measure: Hashable {
    
    var name: String
    var measurement: UnitLength
    
    
    static let example = Measure(name: "km", measurement: UnitLength.kilometers)
    
}
