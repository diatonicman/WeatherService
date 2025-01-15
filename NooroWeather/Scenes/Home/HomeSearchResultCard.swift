
import SwiftUI

struct HomeSearchResultCard: View {
    
    let viewModel: HomeView.ViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 100)
                .foregroundColor(.lightGrayBackground)
            HStack {
                VStack {
                    Text(viewModel.searchResult?.cityName ?? "")
                        .font(.system(size: 30, weight: .semibold))
                    
                    Text("\(Int(viewModel.searchResult?.temperature ?? 0))°")
                        .font(.system(size: 50, weight: .semibold))
                }
                .padding(.leading, 20)
                Spacer()
                if let _ = viewModel.searchResult?.conditionIcon {
                    AsyncImage(url: viewModel.searchResult!.conditionIcon) { result in
                        result.image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100, maxHeight: 100)
                    }.padding(.trailing, 20)
                }
            }
        }
        .onTapGesture {
            viewModel.setPreferredCity(viewModel.searchResult!.cityName)
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
    
    let viewModel = HomeView.ViewModel()
    viewModel.searchResult = weatherData
    
    return HomeSearchResultCard(viewModel: viewModel)
}
