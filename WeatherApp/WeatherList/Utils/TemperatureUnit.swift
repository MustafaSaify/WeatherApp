//
//  TemperatureUnit.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 04/09/2021.
//

import Foundation

enum TemperatureUnit: String {
    case celcius
    case farhenite
    
    var displayUnit: String {
        switch self {
        case .celcius:
            return "ºc"
        case .farhenite:
            return "ºf"
        }
    }
    
    init?(withDisplayUnit displayUnit: String) {
        self = displayUnit == TemperatureUnit.celcius.displayUnit ? .celcius : .farhenite
    }
}
