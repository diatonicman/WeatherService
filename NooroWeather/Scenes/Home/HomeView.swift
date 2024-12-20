//
//  HomeView.swift
//  NooroWeather
//
//  Created by Scott Anderson on 12/19/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(.lightGrayBackground)
                    
                HStack {
                    TextField("Search Location", text: $viewModel.searchText)
                        .padding(.leading, 20)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding()
                        .onTapGesture {
                            Task {
                                await viewModel.search()
                            }
                        }
                }
            }
            .padding(.horizontal, 30)
            
            if viewModel.searchResult != nil {
                HomeSearchResultCard(viewModel: viewModel, weatherData: viewModel.searchResult!)
                Spacer()
            }
            else if viewModel.preferredCity != nil {
                Spacer()
                HomeWeatherCard(viewModel.preferredData)
                    .task {
                        let weather = await viewModel.getWeather(city: viewModel.preferredCity!)
                        viewModel.preferredData = weather
                    }
                Spacer()
            } else {
                Spacer()
                VStack {
                    Text("No City Selected")
                        .font(.title)
                    Text("Please Search For A City")
                        .font(.footnote)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
