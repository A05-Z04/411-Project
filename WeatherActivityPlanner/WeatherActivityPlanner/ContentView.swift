import SwiftUI

struct ContentView: View {
    private enum Tab: Hashable {
        case home
        case forecast
    }

    @State private var selectedTab: Tab = .home

    // Use Fullerton until city search is ready.
    private let cityName = "Fullerton"
    private let latitude = 33.87
    private let longitude = -117.92

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(cityName: cityName, latitude: latitude, longitude: longitude) {
                selectedTab = .forecast
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(Tab.home)

            ForecastView(cityName: cityName, latitude: latitude, longitude: longitude)
                .tabItem {
                    Label("Forecast", systemImage: "cloud.sun.fill")
                }
                .tag(Tab.forecast)
        }
    }
}

#Preview {
    ContentView()
}
