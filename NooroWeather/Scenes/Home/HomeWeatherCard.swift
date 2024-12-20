//
//  HomeWeatherCard.swift
//  NooroWeather
//
//  Created by Scott Anderson on 12/19/24.
//

import SwiftUI

struct HomeWeatherCard: View {
    
    let weatherData: WeatherFetchResponse?
    init (_ response: WeatherFetchResponse?) {
        weatherData = response
    }
    
    var body: some View {
        VStack {
            if weatherData != nil {
                AsyncImage(url: weatherData!.conditionIcon)
            }
    
            Text(weatherData?.cityName ?? "")
                .font(.title)
            Text("\(Int(weatherData?.temperature ?? 0))")
                .font(.title)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 100)
                    .foregroundColor(.lightGrayBackground)
                HStack {
                    VStack{
                        Text("Humidity")
                        Text("\(weatherData?.humidity ?? 0)%")
                    }
                    VStack{
                        Text("UV")
                        Text("\(Int(weatherData?.uvIndex ?? 0))")
                    }
                    VStack{
                        Text("Feels Like")
                        Text("\(Int(weatherData?.feelsLike ?? 0))")
                    }
                }
            }
            .padding(.horizontal, 75)
        }
    }
}

#Preview {
    let weatherData = WeatherFetchResponse(
        cityName: "Seattle",
        temperature: 51.2,
        uvIndex: 0.2,
        conditionDescription: "Cloudy",
        conditionIcon: URL(string:"https://cdn.weatherapi.com/weather/64x64/day/116.png")!,
        feelsLike: 45.7,
        humidity: 87
    )
    HomeWeatherCard(weatherData)
}
