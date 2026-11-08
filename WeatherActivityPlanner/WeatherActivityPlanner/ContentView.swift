
import SwiftUI
import SwiftData

struct ContentView: View {

    private enum Tab: Hashable {
        case home
        case forecast
        case search
        case favorites
    }

    @State private var selectedTab: Tab = .home

    private let cityName = "Fullerton"
    private let latitude = 33.87
    private let longitude = -117.92

    var body: some View {
        TabView(selection: $selectedTab) {

            // Home - Teammate's updated HomeView
            HomeView(
                cityName: cityName,
                latitude: latitude,
                longitude: longitude
            ) {
                selectedTab = .forecast
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(Tab.home)

            // Forecast
            ForecastView(
                cityName: cityName,
                latitude: latitude,
                longitude: longitude
            )
            .tabItem {
                Label("Forecast", systemImage: "cloud.sun.fill")
            }
            .tag(Tab.forecast)

            // City Search - Adrian
            CitySearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)

            // Favorite Cities - Adrian
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag(Tab.favorites)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: FavoriteCity.self,
            inMemory: true
        )
}
