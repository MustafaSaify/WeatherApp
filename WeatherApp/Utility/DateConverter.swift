//
//  DateConverter.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 06/09/2021.
//

import Foundation

class DateConverter {
    class func convertDateString(dateString : String, fromFormat sourceFormat : String, toFormat desFormat : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        dateFormatter.dateFormat = desFormat
        return dateFormatter.string(from: date)
    }
}
