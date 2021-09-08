//
//  DayForecast.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//

import Foundation

struct DayForecastWrapper: Codable {
    var date: String
    var epoch: Double
    var hour: [HourForecast]
    var day: DayForecast
    
    enum CodingKeys: String, CodingKey {
        case date
        case epoch = "date_epoch"
        case hour
        case day
    }
}

struct DayForecast: Codable {
    var condition: Condition?
    var maxTemperatureCelcius: Float
    var maxTemperatureFarhenite: Float
    var minTemperatureCelcius: Float
    var minTemperatureFarhenite: Float
    var avgTemperatureCelcius: Float
    var avgTemperatureFarhenite: Float
    var humidity: Float
    
    enum CodingKeys: String, CodingKey {
        case condition
        case maxTemperatureCelcius = "maxtemp_c"
        case maxTemperatureFarhenite = "maxtemp_f"
        case minTemperatureCelcius = "mintemp_c"
        case minTemperatureFarhenite = "mintemp_f"
        case avgTemperatureCelcius = "avgtemp_c"
        case avgTemperatureFarhenite = "avgtemp_f"
        case humidity = "avghumidity"
    }
}

struct Condition: Codable {
    var text: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case text
        case icon
    }
}
