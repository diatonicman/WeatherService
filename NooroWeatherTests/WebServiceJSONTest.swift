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

}
