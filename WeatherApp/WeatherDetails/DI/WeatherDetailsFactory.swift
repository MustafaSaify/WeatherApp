//
//  WeatherDetailsFactory.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 06/09/2021.
//

import Foundation
import UIKit

class WeatherDetailsFactory {
    
    class func setupModule(withForecast forecast: DayForecastWrapper, temperatureUnit: TemperatureUnit) -> UIViewController {
        let viewModel = WeatherDetailsViewModel(
            forecast: forecast,
            temperatureUnit: temperatureUnit,
            displayModelMapper: getDisplayModelMapper()
        )
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as! WeatherDetailsViewController
        detailsViewController.viewModel = viewModel
        return detailsViewController
    }
    
}

extension WeatherDetailsFactory {
    private class func getDisplayModelMapper() -> WeatherDetailsDisplayModelMapperContractor {
        return WeatherDetailsDisplayModelMapper(
            withDayForecastMapper: DayForecastDisplayModelMapper()
        )
    }
}
