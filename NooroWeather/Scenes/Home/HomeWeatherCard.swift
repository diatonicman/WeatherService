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
                AsyncImage(url: weatherData!.conditionIcon) { result in
                    result.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 150, maxHeight: 150)
                }
            }

            Text(weatherData?.cityName ?? "")
                .font(.system(size: 40, weight: .bold))
            
            Text("\(Int(weatherData?.temperature ?? 0))°")
                .font(.system(size: 90))
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 75)
                    .foregroundColor(.lightGrayBackground)
                HStack {
                    VStack{
                        Text("Humidity")
                            .foregroundColor(.lightGrayText)
                        Text("\(weatherData?.humidity ?? 0)%")
                            .foregroundColor(.darkGrayText)
                    }
                    .padding(.leading, 15)
                    Spacer()
                    VStack{
                        Text("UV")
                            .foregroundColor(.lightGrayText)
                        Text("\(Int(weatherData?.uvIndex ?? 0))")
                            .foregroundColor(.darkGrayText)
                    }
                    Spacer()
                    VStack{
                        Text("Feels Like")
                            .foregroundColor(.lightGrayText)
                            .font(.footnote)
                        Text("\(Int(weatherData?.feelsLike ?? 0))°")
                            .foregroundColor(.darkGrayText)
                    }
                    .padding(.trailing, 15)
                }
            }
            .padding(.horizontal, 35)
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
