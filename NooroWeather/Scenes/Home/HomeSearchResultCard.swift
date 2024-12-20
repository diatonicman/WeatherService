//
//  HomeSearchResultCard.swift
//  NooroWeather
//
//  Created by Scott Anderson on 12/19/24.
//

import SwiftUI

struct HomeSearchResultCard: View {
    
    let viewModel: HomeView.ViewModel
    let weatherData: WeatherFetchResponse
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 100)
                .foregroundColor(.lightGrayBackground)
            HStack {
                VStack {
                    Text(weatherData.cityName)
                        .font(.title)

                    Text("\(Int(weatherData.temperature))°")
                        .font(.title)
                }
                .padding(.leading, 20)
                Spacer()
                AsyncImage(url: weatherData.conditionIcon)
                    .padding(.trailing, 20)
            }
        }
        .onTapGesture {
            viewModel.setPreferredCity(weatherData.cityName)
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
    
    HomeSearchResultCard(viewModel: HomeView.ViewModel(), weatherData: weatherData)
}
