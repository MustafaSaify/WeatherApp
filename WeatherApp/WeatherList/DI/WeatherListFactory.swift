//
//  WeatherListFactory.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 05/09/2021.
//

import Foundation

class WeatherListFactory {
    
    class func setupDependencies(viewController: WeatherListViewController) {
        let viewModel = WeatherListViewModel(
            weatherRepository: getWeatherRepository(),
            displayModelMapper: getDisplayModelMapper()
        )
        viewController.viewModel = viewModel
    }
}

extension WeatherListFactory {
    
    private class func getWeatherRepository() -> WeatherForecastRepositoryContractor {
        return WeatherForecastRepository(
            remoteDatasource: getWeatherForecastRemoteDatasource(),
            localDatasource: getWeatherForecastLocalDatasource()
        )
    }
    
    private class func getWeatherForecastRemoteDatasource() -> WeatherForecastRemoteDatasourceContractor {
        return WeatherForecastRemoteDatasource(
            baseUrl: NetworkConstants.host,
            apiKey: NetworkConstants.weatherApiKey,
            networkManager: getNetworkService()
        )
    }
    
    private class func getWeatherForecastLocalDatasource() -> WeatherForecastLocalDatasourceContractor {
        return WeatherForecastLocalDatasource()
    }
    
    private class func getNetworkService() -> NetworkContractor {
        return NetworkManager()
    }
    
    private class func getDisplayModelMapper() -> DayForecastDisplayModelMapperContractor  {
        return DayForecastDisplayModelMapper()
    }
}
