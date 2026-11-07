import SwiftUI
import SwiftData

struct ContentView: View {

    @State private var selectedTab = 0

    // Use Fullerton until city search is ready.
    private let cityName = "Fullerton"
    private let latitude = 33.87
    private let longitude = -117.92

    var body: some View {

        // Switch between home, forecast, search, and favorites.
        TabView(selection: $selectedTab) {

            HomeView(
                cityName: cityName,
                latitude: latitude,
                longitude: longitude
            ) {
                selectedTab = 1
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)

            ForecastView(
                cityName: cityName,
                latitude: latitude,
                longitude: longitude
            )
            .tabItem {
                Label("Forecast", systemImage: "cloud.sun.fill")
            }
            .tag(1)

            // City Search - Adrian
            CitySearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(2)

            // Favorite Cities - Adrian
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag(3)
        }
    }
}

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

                    if viewModel.isLoading && viewModel.weather == nil {
                        ProgressView("Loading weather...")
                            .frame(maxWidth: .infinity)

                    } else if let weather = viewModel.weather {
                        weatherCard(weather)

                    } else if let error = viewModel.errorMessage {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(error)

                            Button("Try Again") {
                                Task {
                                    await loadWeather()
                                }
                            }
                        }
                    }

                    Button("View 7-Day Forecast") {
                        showForecast()
                    }
                    .buttonStyle(.borderedProminent)

                    // Saved activities will appear here later.
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
            .task {
                await loadWeather()
            }
        }
    }

    private func weatherCard(_ weather: WeatherResponse) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack(spacing: 12) {
                Image(
                    systemName: WeatherCondition.icon(
                        for: weather.current.weather_code
                    )
                )
                .font(.largeTitle)
                .foregroundStyle(.orange)

                VStack(alignment: .leading) {
                    Text("\(Int(weather.current.temperature_2m.rounded()))°F")
                        .font(.largeTitle)
                        .bold()

                    Text(
                        WeatherCondition.description(
                            for: weather.current.weather_code
                        )
                    )
                    .foregroundStyle(.secondary)
                }
            }

            if let high = weather.daily.temperature_2m_max.first,
               let low = weather.daily.temperature_2m_min.first {
                Text(
                    "High \(Int(high.rounded()))°  Low \(Int(low.rounded()))°"
                )
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
        await viewModel.loadWeather(
            latitude: latitude,
            longitude: longitude
        )
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: FavoriteCity.self,
            inMemory: true
        )
}
