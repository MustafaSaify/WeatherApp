//
//  MockDayForecastDisplayModelMapper.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import Foundation
import XCTest
@testable import WeatherApp

class MockDayForecastDisplayModelMapper: DayForecastDisplayModelMapperContractor {
    
    var mapExpectation: XCTestExpectation?
    
    func map(forecasts: [DayForecastWrapper], unit: TemperatureUnit) -> [DayForecastDisplayModel] {
        mapExpectation?.fulfill()
        return []
    }
}
