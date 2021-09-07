//
//  WeatherForecastRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import XCTest
@testable import WeatherApp

class WeatherForecastRepositoryTests: XCTestCase {
    
    var repository: WeatherForecastRepository!

    override func setUpWithError() throws {
        let localDatasource = WeatherForecastLocalDatasource()
        let remoteDatasource = WeatherForecastRemoteDatasource(
            baseUrl: "test_base_url",
            apiKey: "test_key",
            networkManager: NetworkStub(withMockFile: "weather_forecast_response")
        )
        repository = WeatherForecastRepository(remoteDatasource: remoteDatasource, localDatasource: localDatasource)
    }

    override func tearDownWithError() throws {
        
    }

    func testLocalDatasourceReturnsDataFromCacheWhenAvailable() throws {
        // Given
        let forecast = Forecast(dayForecasts: [])
        let city = "TestCity1"
        localDatasource.setForecast(city: city, forecast: forecast)
        
        // When
        let cached = localDatasource.getForecast(city: city)
        
        // Then
        XCTAssertNotNil(cached)
    }
    
    func testLocalDatasourceReturnsNilWhenDataDoestExists() throws {
        // Given
        let city = "TestCity1"
        
        // When
        let cached = localDatasource.getForecast(city: city)
        
        // Then
        XCTAssertNil(cached)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
