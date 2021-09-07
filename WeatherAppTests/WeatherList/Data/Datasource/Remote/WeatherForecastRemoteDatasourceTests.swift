//
//  WeatherForecastRemoteDatasourceTests.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import Foundation
import XCTest
@testable import WeatherApp

class WeatherForecastRemoteDatasourceTests: XCTestCase {
    
    var remoteDatasource: WeatherForecastRemoteDatasource!

    override func setUpWithError() throws {
        remoteDatasource = WeatherForecastRemoteDatasource(
            baseUrl: "test_base_url",
            apiKey: "test_key",
            networkManager: NetworkStub(withMockFile: "weather_forecast_response")
        )
    }


    func testForecastDataOnSuccess() throws {
        // Given
        let city = "TestCity1"
        let expectation = XCTestExpectation(description: "Forecast call success")
        
        // When
        var actual: ForecastResponse? = nil
        remoteDatasource.fetchWeatherForecast(city: city) { (result) in
            switch result {
            case .success(let response):
                actual = response
                expectation.fulfill()
            case .failure: break
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(actual)
        XCTAssertNotNil(actual?.forecast)
        XCTAssertEqual(actual?.forecast.dayForecasts?.count, 1)
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.date, "2021-09-03")
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.epoch, 1630627200)
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.day.avgTemperatureCelcius, 17.6)
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.day.avgTemperatureFarhenite, 63.7)
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.day.minTemperatureCelcius, 12.9)
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.day.maxTemperatureCelcius, 24.4)
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.day.minTemperatureFarhenite, 55.2)
        XCTAssertEqual(actual?.forecast.dayForecasts!.first!.day.maxTemperatureFarhenite, 75.9)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
