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
    var localDatasource: MockWeatherForecastLocalDatasource!
    var remoteDatasource: MockWeatherForecastRemoteDatasource!

    override func setUpWithError() throws {
        localDatasource = MockWeatherForecastLocalDatasource()
        remoteDatasource = MockWeatherForecastRemoteDatasource()
        repository = WeatherForecastRepository(remoteDatasource: remoteDatasource, localDatasource: localDatasource)
    }

    override func tearDownWithError() throws {
        
    }

    func testRepositoryReturnsDataFromCacheWhenAvailable() throws {
        // Given
        let forecast = Forecast(dayForecasts: [])
        let city = "TestCity1"
        localDatasource.setForecast(city: city, forecast: forecast)
        
        // When
        repository.fetchWeatherForecast(city: city) { (result) in }
        
        // Then
        XCTAssertTrue(localDatasource.getForecastCalled)
        XCTAssertFalse(remoteDatasource.fetchForecastCalled)
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
