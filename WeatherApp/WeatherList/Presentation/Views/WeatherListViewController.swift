//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 04/09/2021.
//

import UIKit
import Combine

class WeatherListViewController: UIViewController {
    
    var viewModel: WeatherListViewModelContractor?
    private var city = ""
    private var dailyForecasts: [DayForecastDisplayModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var temperatureUnitSegment: UISegmentedControl!
    
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherListFactory.setupDependencies(viewController: self)
        bindViewModel()
        viewModel?.determineCurrentCity()
    }
    
    private func bindViewModel() {
        
        viewModel?.cityPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (city) in
                self?.city = city
                self?.navigationItem.title = city
                self?.loader.startAnimating()
                self?.viewModel?.fetchWeatherForecast(forCity: city, unit: self?.selectedTemperatureUnit() ?? .celcius)
            })
            .store(in: &cancellables)
        
        viewModel?.dayForecastDisplayModelsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (dailyForecasts) in
                self?.dailyForecasts = dailyForecasts
                self?.tableView.reloadData()
                self?.loader.stopAnimating()
            })
            .store(in: &cancellables)
    }
    
    @IBAction func onUnitChange(sender: UISegmentedControl) {
        let unit = selectedTemperatureUnit()
        loader.startAnimating()
        viewModel?.fetchWeatherForecast(forCity: city, unit: unit)
    }
    
    private func selectedTemperatureUnit() -> TemperatureUnit {
        if let selectedSegmentTitle = temperatureUnitSegment.titleForSegment(at: temperatureUnitSegment.selectedSegmentIndex) {
            return TemperatureUnit(withDisplayUnit: selectedSegmentTitle) ?? .celcius
        }
        return .celcius
    }
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayForecastTableViewCell.reuseIdentifier, for: indexPath) as! DayForecastTableViewCell
        let forecast = dailyForecasts[indexPath.row]
        cell.configure(with: forecast)
        return cell
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let forecastDisplayModel = dailyForecasts[indexPath.row]
        if let forecast = viewModel?.getDomainModelForForcast(withEpoch: forecastDisplayModel.epoch) {
            let detailsViewController = WeatherDetailsFactory.setupModule(withForecast: forecast, temperatureUnit: selectedTemperatureUnit())
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

