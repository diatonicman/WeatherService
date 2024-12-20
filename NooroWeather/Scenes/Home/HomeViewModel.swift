//
//  HomeViewModel.swift
//  NooroWeather
//
//  Created by Scott Anderson on 12/19/24.
//

import Foundation

extension HomeView {
    
    @Observable
    class ViewModel {
        let preferredCityKey = "WEATHER_PREFERRED_CITY"
        var preferredCity: String?
        var preferredData: WeatherFetchResponse?
        var searchResult: WeatherFetchResponse?
        
        var searchText: String = ""
        let weatherService: WeatherService  = WeatherServiceJSON()
        
        init() {
            preferredCity = getPreferredCity()
        }
        
        func search() async {
            print("Search triggered with \(searchText)")
            if searchText.isEmpty {
                return
            }
            
            if let weather = await getWeather(city: searchText) {
                searchResult = weather
            }
        }

        func getWeather(city: String) async -> WeatherFetchResponse? {
            do {
                return try await weatherService.fetchWeather(for: WeatherFetchRequest(cityName: city))
            } catch {
                return nil
            }
        }
        
        func getPreferredCity() -> String? {
            UserDefaults.standard.string(forKey: preferredCityKey)
        }
        
        func setPreferredCity(_ city: String) {
            print("Set Preferred City. \(city)")
            UserDefaults.standard.set(city, forKey: preferredCityKey)
            preferredCity = city
            preferredData = searchResult
            searchResult = nil
        }
    }
}
