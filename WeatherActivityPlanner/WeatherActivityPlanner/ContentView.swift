import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    // Use Fullerton until city search is ready.
    private let cityName = "Fullerton"
    private let latitude = 33.87
    private let longitude = -117.92

    var body: some View {
        // Switch between home and forecast.
        TabView(selection: $selectedTab) {
            HomeView(cityName: cityName, latitude: latitude, longitude: longitude) {
                selectedTab = 1
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)

            ForecastView(cityName: cityName, latitude: latitude, longitude: longitude)
                .tabItem {
                    Label("Forecast", systemImage: "cloud.sun.fill")
                }
                .tag(1)
        }
    }
}


#Preview {
    ContentView()
}
