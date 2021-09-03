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
    
    var baseUrl: String
    var apiKey: String
    var networkManager: NetworkContractor
    
    init(baseUrl: String, apiKey: String, networkManager: NetworkContractor) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.networkManager = networkManager
    }
    
    func fetchWeatherForecast(city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        let request = WeatherForecastNetworkRequest(baseUrl: baseUrl, apiKey: apiKey, city: city)
        networkManager.sendRequest(request: request, completion: completion)
    }
}
