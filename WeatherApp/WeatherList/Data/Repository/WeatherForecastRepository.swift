//
//  WeatherForecastRepositoryContractor.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//

import Foundation

protocol WeatherForecastRepositoryContractor {
    func fetchWeatherForecast(city: String, completion: @escaping (Result<Forecast, Error>) -> Void)
}

class WeatherForecastRepository: WeatherForecastRepositoryContractor {
    
    private var remoteDatasource: WeatherForecastRemoteDatasourceContractor
    private var localDatasource: WeatherForecastLocalDatasourceContractor?
    
    init(remoteDatasource: WeatherForecastRemoteDatasourceContractor,
         localDatasource: WeatherForecastLocalDatasourceContractor?) {
        self.remoteDatasource = remoteDatasource
        self.localDatasource = localDatasource
    }
    
    
    func fetchWeatherForecast(city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        if let cachedForecast = localDatasource?.getForecast(city: city) {
            completion(.success(cachedForecast))
            return
        }
        remoteDatasource.fetchWeatherForecast(city: city) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.localDatasource?.setForecast(city: city, forecast: response.forecast)
                completion(Result.success(response.forecast))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
