//
//  WeatherService.swift
//  NooroWeather
//
//  Created by Scott Anderson on 12/19/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for request: WeatherFetchRequest) async throws -> WeatherFetchResponse
}

struct WeatherFetchRequest: Encodable {
    let cityName: String //Name of city to search
}

struct WeatherFetchResponse: Decodable {
    let cityName: String
    let temperature: Double
    let uvIndex: Double
    let conditionDescription: String
    let conditionIcon: URL
    let feelsLike: Double
}

enum WeatherServiceError: Error {
    case cityNotFound
    case timeout
    case invalidResponse
}
