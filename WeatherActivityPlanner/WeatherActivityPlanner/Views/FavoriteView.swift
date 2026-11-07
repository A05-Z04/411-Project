import SwiftUI
import SwiftData

struct FavoritesView: View {

    @Environment(\.modelContext) private var modelContext

    @Query(sort: \FavoriteCity.name)
    private var favoriteCities: [FavoriteCity]

    var body: some View {
        NavigationStack {
            Group {
                if favoriteCities.isEmpty {
                    ContentUnavailableView(
                        "No Favorite Cities",
                        systemImage: "star",
                        description: Text(
                            "Search for a city and tap the star to save it here."
                        )
                    )
                } else {
                    List {
                        ForEach(favoriteCities) { city in
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

                                    Text(city.country)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteFavorites)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }

    private func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(favoriteCities[index])
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to delete favorite: \(error)")
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(
            for: FavoriteCity.self,
            inMemory: true
        )
}
