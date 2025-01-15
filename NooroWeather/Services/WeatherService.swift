
import Foundation

protocol WeatherService {
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
    let humidity: Int
}

enum WeatherServiceError: Error {
    case cityNotFound
    case invalidResponse
    case timeout
}
