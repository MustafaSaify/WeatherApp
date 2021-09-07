//
//  WeatherListTableViewCell.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 05/09/2021.
//

import UIKit
import Kingfisher

class DayForecastTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avgTemperatureLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func prepareForReuse() {
        iconView.kf.cancelDownloadTask()
    }
    
    func configure(with displayModel: WeatherListItemDisplayModel) {
        dateLabel.text = displayModel.date
        avgTemperatureLabel.text = displayModel.averageTemperature
        conditionsLabel.text = displayModel.conditions
        maxTemperatureLabel.text = displayModel.maxTemperature
        minTemperatureLabel.text = displayModel.minTemperature
        iconView.kf.setImage(with: displayModel.iconUrl)
    }

}
