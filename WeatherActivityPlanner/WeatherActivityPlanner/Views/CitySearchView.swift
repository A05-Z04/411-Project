import SwiftUI
import SwiftData

struct CitySearchView: View {

    @StateObject private var viewModel = CitySearchViewModel()

    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteCities: [FavoriteCity]

    var body: some View {

        NavigationStack {
            VStack(spacing: 0) {

                if viewModel.isLoading {
                    ProgressView("Searching cities...")
                        .padding()

                } else if let error = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Search Failed",
                        systemImage: "wifi.exclamationmark",
                        description: Text(error)
                    )

                } else if viewModel.cities.isEmpty {
                    ContentUnavailableView(
                        "Find a City",
                        systemImage: "magnifyingglass",
                        description: Text("Search for a city to view its weather.")
                    )

                } else {
                    List(viewModel.cities) { city in

                        HStack(spacing: 12) {

                            NavigationLink {
                                ForecastView(
                                    cityName: city.name,
                                    latitude: city.latitude,
                                    longitude: city.longitude
                                )
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {

                                    Text(city.name)
                                        .font(.headline)

                                    Text(city.displayName)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            Button {
                                toggleFavorite(city)
                            } label: {
                                Image(
                                    systemName: isFavorite(city)
                                        ? "star.fill"
                                        : "star"
                                )
                                .foregroundStyle(.yellow)
                                .font(.title3)
                            }
                            .buttonStyle(.borderless)
                            .accessibilityLabel(
                                isFavorite(city)
                                    ? "Remove \(city.name) from favorites"
                                    : "Add \(city.name) to favorites"
                            )
                        }
                    }
                }
            }
            .navigationTitle("City Search")
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search cities"
            )
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchCities()
                }
            }
        }
    }

    // Check whether a city is already saved.
    private func isFavorite(_ city: City) -> Bool {
        favoriteCities.contains { favorite in
            favorite.cityID == city.id
        }
    }

    // Add or remove a city from SwiftData.
    private func toggleFavorite(_ city: City) {

        if let existingFavorite = favoriteCities.first(where: {
            $0.cityID == city.id
        }) {
            modelContext.delete(existingFavorite)

        } else {
            let newFavorite = FavoriteCity(city: city)
            modelContext.insert(newFavorite)
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to save favorite city: \(error)")
        }
    }
}

#Preview {
    CitySearchView()
        .modelContainer(
            for: FavoriteCity.self,
            inMemory: true
        )
}
