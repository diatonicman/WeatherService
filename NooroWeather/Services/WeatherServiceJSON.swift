//
//  WeatherServiceJSON.swift
//  NooroWeather
//
//  Created by Scott Anderson on 12/19/24.
//

import Foundation

struct WeatherServiceJSON : WeatherServiceProtocol {
    
    static let schemeKey    = "WEATHER_SERVICE_SCHEME"
    static let hostKey      = "WEATHER_SERVICE_HOST"
    static let pathKey      = "WEATHER_SERVICE_PATH"
    static let apiKeyKey    = "WEATHER_SERVICE_API_KEY"
    
    func fetchWeather(for request: WeatherFetchRequest) async throws -> WeatherFetchResponse {
        throw WeatherServiceError.cityNotFound
    }
    
    func buildURL(for request: WeatherFetchRequest) -> URL? {
        
        guard let scheme = Bundle.main.object(forInfoDictionaryKey:WeatherServiceJSON.schemeKey) as? String else {
            print("Can't find scheme")
            return nil
        }
        
        guard let hostName = Bundle.main.object(forInfoDictionaryKey:WeatherServiceJSON.hostKey) as? String else {
            print("Can't find host name")
            return nil
        }
        
        guard let path = Bundle.main.object(forInfoDictionaryKey:WeatherServiceJSON.pathKey) as? String else {
            print("Can't find path")
            return nil
        }
        
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey:WeatherServiceJSON.apiKeyKey) as? String else {
            print("Can't find api key")
            return nil
        }
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = hostName
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: request.cityName)
        ]
        
        return components.url
    }
}


//
// Generated with Quicktype
//

// MARK: - WeatherFetchJSONResponse
struct WeatherFetchJSONResponse: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph: Double
    let windKph, windDegree: Int
    let windDir: String
    let pressureMB: Int
    let pressureIn, precipMm: Double
    let precipIn, humidity, cloud: Int
    let feelslikeC: Double
    let feelslikeF: Int
    let windchillC: Double
    let windchillF: Int
    let heatindexC, heatindexF: Double
    let dewpointC: Int
    let dewpointF: Double
    let visKM, visMiles, uv: Int
    let gustMph, gustKph: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
