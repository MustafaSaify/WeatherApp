//
//  WeatherListViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import XCTest
@testable import WeatherApp

class WeatherListViewModelTests: XCTestCase {
    
    var repository: MockWeatherForecastRepository!
    var displayModelMapper: MockDayForecastDisplayModelMapper!
    var viewModel: WeatherListViewModel!

    override func setUpWithError() throws {
        repository = MockWeatherForecastRepository()
        displayModelMapper = MockDayForecastDisplayModelMapper()
        viewModel = WeatherListViewModel(weatherRepository: repository, displayModelMapper: displayModelMapper)
    }

    func testViewModelFetchesWeatherDataFromRepository() throws {
        // Given
        let city = "TestCity1"
        let temperatureUnit = TemperatureUnit.celcius
        let fetchWeatherForecastExpectation = XCTestExpectation(description: "fetch_weather_expectation")
        repository.fetchWeatherForecastExpectation = fetchWeatherForecastExpectation
        
        // When
        viewModel.fetchWeatherForecast(forCity: city, unit: temperatureUnit)
        
        // Then
        wait(for: [fetchWeatherForecastExpectation], timeout: 1.0)
    }
    
    func testViewModelCovertDomainToDisplayModelUsingDisplayMapper() throws {
        // Given
        let city = "TestCity1"
        let temperatureUnit = TemperatureUnit.celcius
        let mapExpectation = XCTestExpectation(description: "fetch_weather_expectation")
        repository.result = .success(Forecast(dayForecasts: []))
        displayModelMapper.mapExpectation = mapExpectation
        
        // When
        viewModel.fetchWeatherForecast(forCity: city, unit: temperatureUnit)
        
        // Then
        wait(for: [mapExpectation], timeout: 1.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
