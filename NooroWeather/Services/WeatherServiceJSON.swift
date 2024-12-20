//
//  WeatherServiceJSON.swift
//  NooroWeather
//
//  Created by Scott Anderson on 12/19/24.
//

import Foundation

struct WeatherServiceJSON : WeatherService {
    
    static let schemeKey    = "WEATHER_SERVICE_SCHEME"
    static let hostKey      = "WEATHER_SERVICE_HOST"
    static let pathKey      = "WEATHER_SERVICE_PATH"
    static let apiKeyKey    = "WEATHER_SERVICE_API_KEY"
    
    let decoder = JSONDecoder()
    
    func fetchWeather(for request: WeatherFetchRequest) async throws -> WeatherFetchResponse {
        
        guard let url = buildURL(for: request) else {
            throw WeatherServiceError.invalidResponse
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherServiceError.invalidResponse
        }
        
        //Server sends back a 400 response code when it can't find the city
        if httpResponse.statusCode == 400 {
            throw WeatherServiceError.cityNotFound
        }
        else if httpResponse.statusCode != 200 {
            throw WeatherServiceError.invalidResponse
        }
        
        let weatherResponse = try decoder.decode(WeatherFetchJSONResponse.self, from: data)
        
        return try buildResponse(from: weatherResponse)
    }
    
    func buildResponse(from response: WeatherFetchJSONResponse) throws -> WeatherFetchResponse {
        
        guard let iconURL = URL(string: "https:\(response.current.condition.icon)") else {
            throw WeatherServiceError.invalidResponse
        }
        
        return WeatherFetchResponse(
            cityName: response.location.name,
            temperature: response.current.tempF,
            uvIndex: response.current.uv,
            conditionDescription: response.current.condition.text,
            conditionIcon: iconURL,
            feelsLike: response.current.feelslikeF,
            humidity: response.current.humidity
        )
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


/*
 Generated with Quicktype.
 
 QuickType seems to get confused about Doubles that are whole Integers. eg 35.0 is translated to INT where 35.1 is a Double. Changed intput code to quick type to make sure there are no whole Integers.
*/

// MARK: - WeatherFetchJSONResponse
struct WeatherFetchJSONResponse: Codable {
    let location: WeatherFetchJSONResponseLocation
    let current: WeatherFetchJSONResponseCurrent
}

// MARK: - WeatherFetchJSONResponseCurrent
struct WeatherFetchJSONResponseCurrent: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: WeatherFetchJSONResponseCondition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMB, pressureIn, precipMm, precipIn: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF, windchillC, windchillF: Double
    let heatindexC, heatindexF, dewpointC, dewpointF: Double
    let visKM, visMiles, uv, gustMph: Double
    let gustKph: Double

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

// MARK: - WeatherFetchJSONResponseCondition
struct WeatherFetchJSONResponseCondition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - WeatherFetchJSONResponseLocation
struct WeatherFetchJSONResponseLocation: Codable {
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
