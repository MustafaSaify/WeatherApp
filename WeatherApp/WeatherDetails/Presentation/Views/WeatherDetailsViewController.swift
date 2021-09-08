//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 05/09/2021.
//

import UIKit
import Combine

private enum Section: Int, CaseIterable {
    case summary = 0
    case hourlyDetails = 1
}

class WeatherDetailsViewController: UIViewController {

    var viewModel: WeatherDetailsViewModelContractor?
    private var displayModel: WeatherDetailsDisplayModel!
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel?.getForecastDetails()
    }
    
    private func bindViewModel() {
        viewModel?.displayModelPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (displayModel) in
                self?.displayModel = displayModel
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

extension WeatherDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayModel != nil ? Section.allCases.count : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Section.summary.rawValue ? 1 : displayModel.hourlyForecastDisplayModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)
        if section == .summary {
            let dayForecastCell = tableView.dequeueReusableCell(withIdentifier: DayForecastTableViewCell.reuseIdentifier, for: indexPath) as! DayForecastTableViewCell
            dayForecastCell.configure(with: displayModel.dayForecastDisplayModel)
            return dayForecastCell
        }
        else {
            let hourlyForcastDisplayModel = displayModel.hourlyForecastDisplayModel[indexPath.row]
            let hourlyForecastCell = tableView.dequeueReusableCell(withIdentifier: HourlyForecastTableViewCell.reuseIdentifier, for: indexPath) as! HourlyForecastTableViewCell
            hourlyForecastCell.configure(with: hourlyForcastDisplayModel)
            return hourlyForecastCell
        }
    }
}

extension WeatherDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == Section.hourlyDetails.rawValue ? "Hourly Forecast" : ""
    }
}
