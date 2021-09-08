//
//  MockWeatherForecastRemoteDatasource.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import Foundation
@testable import WeatherApp

class MockWeatherForecastRemoteDatasource: WeatherForecastRemoteDatasourceContractor {
    
    var fetchForecastCalled = false
    
    func fetchWeatherForecast(city: String, completion: @escaping (Result<ForecastResponse, Error>) -> Void) {
        fetchForecastCalled = true
    }
}
