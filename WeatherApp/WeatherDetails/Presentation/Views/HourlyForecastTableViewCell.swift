//
//  HourlyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 06/09/2021.
//

import UIKit
import Kingfisher

class HourlyForecastTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.kf.cancelDownloadTask()
    }
    
    func configure(with displayModel: HourlyForecastDisplayModel) {
        hourLabel.text = displayModel.hour
        temperatureLabel.text = displayModel.temperature
        iconView.kf.setImage(with: displayModel.iconUrl)
    }
}
