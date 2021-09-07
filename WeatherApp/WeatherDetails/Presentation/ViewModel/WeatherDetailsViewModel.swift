//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 05/09/2021.
//

import Foundation
import Combine

protocol WeatherDetailsViewModelContractor {
    var displayModelPublisher: Published<WeatherDetailsDisplayModel?>.Publisher { get }
    func getForecastDetails()
}

class WeatherDetailsViewModel: WeatherDetailsViewModelContractor {
    
    @Published private var displayModel: WeatherDetailsDisplayModel?
    var displayModelPublisher: Published<WeatherDetailsDisplayModel?>.Publisher { $displayModel }
    
    private var forecast: DayForecastWrapper
    private var temperatureUnit: TemperatureUnit
    private var displayModelMapper:WeatherDetailsDisplayModelMapperContractor
    
    init(forecast: DayForecastWrapper, temperatureUnit: TemperatureUnit, displayModelMapper: WeatherDetailsDisplayModelMapperContractor) {
        self.forecast = forecast
        self.temperatureUnit = temperatureUnit
        self.displayModelMapper = displayModelMapper
    }
    
    func getForecastDetails() {
        self.displayModel = displayModelMapper.mapWeatherDetails(forForecast: forecast, temperatureUnit: temperatureUnit)
    }
}
