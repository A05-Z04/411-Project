import SwiftUI

struct HomeView: View {
    let cityName: String
    let latitude: Double
    let longitude: Double
    let showForecast: () -> Void

    @StateObject private var viewModel = ForecastViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(cityName)
                        .font(.title)
                        .bold()

                    weatherSection

                    Button("View 7-Day Forecast") {
                        showForecast()
                    }
                    .buttonStyle(.borderedProminent)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Upcoming Activities")
                            .font(.title2)
                            .bold()

                        Text("No activities planned yet. Your saved activities will appear here.")
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .navigationTitle("Home")
            .refreshable {
                await loadWeather()
            }
            .task {
                if viewModel.weather == nil {
                    await loadWeather()
                }
            }
        }
    }

    private var weatherSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let weather = viewModel.weather {
                weatherCard(weather)
            }

            if let error = viewModel.errorMessage {
                Text(viewModel.weather == nil ? error : "Couldn't refresh. Showing the last weather loaded.")
                    .foregroundStyle(.secondary)

                Button("Try Again") {
                    Task {
                        await loadWeather()
                    }
                }
            } else if viewModel.weather == nil {
                ProgressView("Loading weather...")
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func weatherCard(_ weather: WeatherResponse) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: WeatherCondition.icon(for: weather.current.weather_code))
                    .font(.largeTitle)
                    .foregroundStyle(.orange)

                VStack(alignment: .leading) {
                    Text("\(Int(weather.current.temperature_2m.rounded()))°F")
                        .font(.largeTitle)
                        .bold()

                    Text(WeatherCondition.description(for: weather.current.weather_code))
                        .foregroundStyle(.secondary)
                }
            }

            if let high = weather.daily.temperature_2m_max.first,
               let low = weather.daily.temperature_2m_min.first {
                Text("High \(Int(high.rounded()))°  Low \(Int(low.rounded()))°")
            }

            if let rainChance = weather.daily.precipitation_probability_max.first {
                Text("Chance of rain: \(rainChance)%")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func loadWeather() async {
        // Skip the request if weather is already loading.
        guard !viewModel.isLoading else { return }

        await viewModel.loadWeather(latitude: latitude, longitude: longitude)
    }
}
