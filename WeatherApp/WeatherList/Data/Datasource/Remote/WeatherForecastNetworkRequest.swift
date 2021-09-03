//
//  WeatherForecastRequest.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//

import Foundation

class WeatherForecastNetworkRequest: NetworkRequest {
    
    var baseUrl: String
    var city: String
    var days: Int
    var apiKey: String
    
    init(baseUrl: String, apiKey: String, city: String, days: Int = 5) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.city = city
        self.days = days
    }
    
    var urlRequest: URLRequest {
        return URLRequest(baseURL: URL(string: baseUrl)!,
                          path: "v1/forecast.json",
                          parameters: queryParams)!
    }
    
    private var queryParams: [String : AnyObject] {
        return ["key" : apiKey,
                "q" : city,
                "days" : days,
                "aqi" : "no",
                "alerts" : "no"] as [String : AnyObject]
    }
}
