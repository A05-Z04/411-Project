import Foundation
import Combine

@MainActor
class CitySearchViewModel: ObservableObject {

    @Published var searchText = ""
    @Published var cities: [City] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let citySearchService = CitySearchService()

    func searchCities() async {

        let query = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard query.count >= 2 else {
            cities = []
            errorMessage = nil
            isLoading = false
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            cities = try await citySearchService.searchCities(
                query: query
            )
        } catch {
            cities = []
            errorMessage = "Unable to search cities. Please try again."
        }

        isLoading = false
    }
}

