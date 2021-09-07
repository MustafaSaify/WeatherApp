//
//  MockWeatherForecastRepository.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import Foundation
import XCTest
@testable import WeatherApp

class MockWeatherForecastRepository: WeatherForecastRepositoryContractor {
    
    var fetchWeatherForecastExpectation: XCTestExpectation?
    var result: Result<Forecast, Error>?
    
    func fetchWeatherForecast(city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        fetchWeatherForecastExpectation?.fulfill()
        completion(result ?? .failure(NSError()))
    }
}
