//
//  Forecast.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//

import Foundation

struct ForecastResponse: Codable {
    var forecast: Forecast
}

struct Forecast: Codable {
    
    var dayForecasts: [DayForecastWrapper]?

    enum CodingKeys: String, CodingKey {
        case dayForecasts = "forecastday"
    }
}
