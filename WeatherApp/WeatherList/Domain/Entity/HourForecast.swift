//
//  HourForecast.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//

import Foundation

struct HourForecast: Codable {
    var time: String
    var tempCelcius: Float
    var tempFarhenite: Float
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempCelcius = "temp_c"
        case tempFarhenite = "temp_f"
        case condition
    }
}
