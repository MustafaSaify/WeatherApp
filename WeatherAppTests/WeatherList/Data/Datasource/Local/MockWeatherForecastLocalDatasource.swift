//
//  MockWeatherForecastLocalDatasource.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import Foundation
@testable import WeatherApp

class MockWeatherForecastLocalDatasource: WeatherForecastLocalDatasourceContractor {
    
    var getForecastCalled = false
    var forecast: Forecast?
    
    func getForecast(city: String) -> Forecast? {
        getForecastCalled = true
        return forecast
    }
    
    func setForecast(city: String, forecast: Forecast) {
        self.forecast = forecast
    }
}
