//
//  WeatherForecastLocalDatasource.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//

import Foundation

protocol WeatherForecastLocalDatasourceContractor {
    func getForecast(city: String) -> Forecast?
    func setForecast(city: String, forecast: Forecast)
}

class WeatherForecastLocalDatasource: WeatherForecastLocalDatasourceContractor {
    
    private var cache: [String: Forecast] = [:]
    
    func getForecast(city: String) -> Forecast? {
        cache[city]
    }
    
    func setForecast(city: String, forecast: Forecast) {
        cache[city] = forecast
    }
}
