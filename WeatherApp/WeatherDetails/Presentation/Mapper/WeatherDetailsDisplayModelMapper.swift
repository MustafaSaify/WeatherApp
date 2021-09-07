//
//  WeatherDetailsDisplayModelMapper.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 05/09/2021.
//

import Foundation

protocol WeatherDetailsDisplayModelMapperContractor {
    func mapWeatherDetails(forForecast forecast: DayForecastWrapper, temperatureUnit: TemperatureUnit) -> WeatherDetailsDisplayModel
}

class WeatherDetailsDisplayModelMapper: WeatherDetailsDisplayModelMapperContractor {
    
    // Composition
    var dayForecastMapper: DayForecastDisplayModelMapperContractor
    
    init(withDayForecastMapper dayForecastMapper: DayForecastDisplayModelMapperContractor) {
        self.dayForecastMapper = dayForecastMapper
    }
    
    func mapWeatherDetails(forForecast forecast: DayForecastWrapper, temperatureUnit: TemperatureUnit) -> WeatherDetailsDisplayModel {
        let dayForecastDisplayModel = dayForecastMapper.map(forecasts: [forecast], unit: temperatureUnit).first!
        let hourlyForecasts = forecast.hour.map({mapHourlyForcast(hourForcast: $0, temperatureUnit: temperatureUnit)})
        return WeatherDetailsDisplayModel(
            dayForecastDisplayModel: dayForecastDisplayModel,
            hourlyForecastDisplayModel: hourlyForecasts
        )
    }
    
    private func mapHourlyForcast(hourForcast: HourForecast, temperatureUnit: TemperatureUnit) -> HourlyForecastDisplayModel {
        let hour = hourForcast.time
        let temperatur = _getFormattedTemperature(
            value: temperatureUnit == .celcius ? hourForcast.tempCelcius : hourForcast.tempFarhenite,
            unit: temperatureUnit
        )
        
        let iconPath = hourForcast.condition.icon != nil ? "http:\(hourForcast.condition.icon!)" : ""
        
        return HourlyForecastDisplayModel(
            hour: DateConverter.convertDateString(dateString: hour, fromFormat: "YYYY-MM-dd HH:mm", toFormat: "hh:mm a"),
            temperature: temperatur,
            iconUrl: URL(string: iconPath)
        )
        
    }
    
    private func _getFormattedTemperature(value: Float, unit: TemperatureUnit) -> String {
        return "\(value) \(unit.displayUnit)"
    }
}
