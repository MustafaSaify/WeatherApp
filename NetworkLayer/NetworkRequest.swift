//
//  RequestModel.swift
//  WeatherApp
//
//  Created by Mustafa.saify on 03/09/2021.
//
import Foundation

protocol NetworkRequest {
    var urlRequest: URLRequest { get }
}
