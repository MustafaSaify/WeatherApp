//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 04/09/2021.
//

import Foundation

protocol WeatherListViewModelContractor {
    func determineCurrentCity()
    func fetchWeatherForecast(forCity city: String, unit: TemperatureUnit)
    var dayForecastDisplayModelsPublisher: Published<[DayForecastDisplayModel]>.Publisher { get }
    var cityPublisher: Published<String>.Publisher { get }
    func getDomainModelForForcast(withEpoch epoch: Double) -> DayForecastWrapper?
}

class WeatherListViewModel: WeatherListViewModelContractor {
    
    @Published private var dayForecastDisplayModels: [DayForecastDisplayModel] = []
    var dayForecastDisplayModelsPublisher: Published<[DayForecastDisplayModel]>.Publisher { $dayForecastDisplayModels }
    
    @Published private var city: String = ""
    var cityPublisher: Published<String>.Publisher { $city }
    
    private var forecasts: [DayForecastWrapper] = []
    var weatherRepository: WeatherForecastRepositoryContractor?
    var displayModelMapper: DayForecastDisplayModelMapperContractor?
    
    init(weatherRepository: WeatherForecastRepositoryContractor?,
         displayModelMapper: DayForecastDisplayModelMapperContractor?) {
        self.weatherRepository = weatherRepository
        self.displayModelMapper = displayModelMapper
    }
    
    func determineCurrentCity() {
        // hardcoding user location to Dubai to limit the scope of the problem. Ideally the app would determine the user's current location.
        city = "Dubai"
    }
    
    func fetchWeatherForecast(forCity city: String, unit: TemperatureUnit) {
        weatherRepository?.fetchWeatherForecast(city: city, completion: { [weak self] (result) in
            switch result {
            case .success(let forecast):
                self?.forecasts = forecast.dayForecasts ?? []
                self?.dayForecastDisplayModels = self?.displayModelMapper?.map(forecasts: forecast.dayForecasts ?? [], unit: unit) ?? []
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getDomainModelForForcast(withEpoch epoch: Double) -> DayForecastWrapper? {
        return forecasts.first{$0.epoch == epoch}
    }
    
}
