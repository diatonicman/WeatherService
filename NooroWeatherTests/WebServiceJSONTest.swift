//
//  WebServiceJSONTest.swift
//  NooroWeatherTests
//
//  Created by Scott Anderson on 12/19/24.
//

import Foundation
import Testing

@testable import NooroWeather

struct WebServiceJSONTest {
    
    let request  = WeatherFetchRequest(cityName: "Seattle")
    
    @Test("WeatherService JSON URL Builder")
    func testbuildURL() async throws {
        
        let weatherService = WeatherServiceJSON()
        let url = weatherService.buildURL(for: request)
        #expect(url != nil)
        
        let expectedURLString = "https://api.weatherapi.com/v1/current.json?key=7ae557f395f44dbf80674757241912&q=Seattle"
        let expectedURL = URL(string: expectedURLString)!
        #expect(url == expectedURL)
        
    }
    
    @Test("WeatherService JSON Decoder")
    func testBuildResponse() throws {
        let weatherService = WeatherServiceJSON()
        let response = try weatherService.buildResponse(from: testWeatherFetchJSONResponse)
    
        #expect(response.cityName == testWeatherFetchJSONResponse.location.name)
        #expect(response.temperature == testWeatherFetchJSONResponse.current.tempF)
        #expect(response.conditionDescription == testWeatherFetchJSONResponse.current.condition.text)
        #expect(response.feelsLike == testWeatherFetchJSONResponse.current.feelslikeF)
        #expect(response.uvIndex == testWeatherFetchJSONResponse.current.uv)
        #expect(response.conditionIcon.absoluteString == testWeatherFetchJSONResponse.current.condition.icon)
        #expect(response.humidity == testWeatherFetchJSONResponse.current.humidity)
        
    }
    
    @Test("Live Weather Service Test")
    func testService() async throws {
        let weatherService = WeatherServiceJSON()
        let response = try await weatherService.fetchWeather(for: request)
        #expect(response.cityName == request.cityName)
    }
    
}
                
let testWeatherFetchJSONResponse = WeatherFetchJSONResponse(
    location: WeatherFetchJSONResponseLocation(
        name: "Seattle",
        region: "Washington",
        country: "United States of America",
        lat: 47.6064,
        lon: -122.3308,
        tzID: "America/Los_Angeles",
        localtimeEpoch: 1734650980,
        localtime: "2024-12-19 15:29"),
    current: WeatherFetchJSONResponseCurrent(
        lastUpdatedEpoch: 1734650100,
        lastUpdated: "2024-12-19 15:15",
        tempC: 11.7,
        tempF: 53.1,
        isDay: 1,
        condition: WeatherFetchJSONResponseCondition(
            text: "Partly Cloudy",
            icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
            code: 1003),
        windMph: 2.9,
        windKph: 4.7,
        windDegree: 162,
        windDir: "SSE",
        pressureMB: 1015.0,
        pressureIn: 29.98,
        precipMm: 0.0,
        precipIn: 0.0,
        humidity: 73,
        cloud: 31,
        feelslikeC: 10.7,
        feelslikeF: 51.3,
        windchillC: 10.7,
        windchillF: 51.3,
        heatindexC: 11.7,
        heatindexF: 53.1,
        dewpointC: 7.7,
        dewpointF: 53.1,
        visKM: 10.0,
        visMiles: 6.0,
        uv: 0.2,
        gustMph: 4.5,
        gustKph: 7.3)
    )
