//
//  WeatherForecastRemoteDatasource.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//

import Foundation

protocol WeatherForecastRemoteDatasourceContractor {
    func fetchWeatherForecast(city: String, completion: @escaping (Result<Forecast, Error>) -> Void)
}

class WeatherForecastRemoteDatasource: WeatherForecastRemoteDatasourceContractor {
    
    func fetchWeatherForecast(city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        
    }
}
