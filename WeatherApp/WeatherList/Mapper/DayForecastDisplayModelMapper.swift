//
//  DayForecastDisplayModelMapper.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 04/09/2021.
//

import Foundation

protocol DayForecastDisplayModelMapperContractor {
    func map(forecasts: [DayForecastWrapper], unit: TemperatureUnit) -> [DayForecastDisplayModel]
}

class DayForecastDisplayModelMapper : DayForecastDisplayModelMapperContractor {
    
    func map(forecasts: [DayForecastWrapper], unit: TemperatureUnit) -> [DayForecastDisplayModel] {
        return forecasts.map{self.map(dayForecast: $0, unit: unit)}
    }
    
    private func map(dayForecast: DayForecastWrapper, unit: TemperatureUnit) -> DayForecastDisplayModel {
        let averageTemperature = _getFormattedTemperature(
            value: unit == .celcius ? dayForecast.day.avgTemperatureCelcius : dayForecast.day.avgTemperatureFarhenite,
            unit: unit
        )
        
        let maxTemperature = _getFormattedTemperature(
            value: unit == .celcius ? dayForecast.day.maxTemperatureCelcius : dayForecast.day.maxTemperatureFarhenite,
            unit: unit
        )
        
        let minTemperature = _getFormattedTemperature(
            value: unit == .celcius ? dayForecast.day.minTemperatureCelcius : dayForecast.day.minTemperatureFarhenite,
            unit: unit
        )
        
        let iconPath = dayForecast.day.condition?.icon != nil ? "http:\(dayForecast.day.condition!.icon!)" : ""
        
        return DayForecastDisplayModel(
            epoch: dayForecast.epoch,
            date: DateConverter.convertDateString(dateString: dayForecast.date, fromFormat: "YYYY-MM-dd", toFormat: "dd MMM"),
            conditions: dayForecast.day.condition?.text ?? "",
            averageTemperature: averageTemperature,
            maxTemperature: "Max: \(maxTemperature)",
            minTemperature: "Min: \(minTemperature)",
            iconUrl: URL(string: iconPath)
        )
        
    }
    
    private func _getFormattedTemperature(value: Float, unit: TemperatureUnit) -> String {
        return "\(value) \(unit.displayUnit)"
    }
}
