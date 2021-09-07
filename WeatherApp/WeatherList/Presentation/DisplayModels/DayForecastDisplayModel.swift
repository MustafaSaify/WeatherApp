//
//  WeatherListCellDisplayModel.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 04/09/2021.
//

import Foundation

struct DayForecastDisplayModel {
    var epoch: Double
    var date: String
    var conditions: String
    var averageTemperature: String
    var maxTemperature: String
    var minTemperature: String
    var iconUrl: URL?
}
