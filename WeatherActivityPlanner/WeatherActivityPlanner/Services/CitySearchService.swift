import Foundation

class CitySearchService {

    func searchCities(query: String) async throws -> [City] {

        let searchText = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard searchText.count >= 2 else {
            return []
        }

        var components = URLComponents(
            string: "https://geocoding-api.open-meteo.com/v1/search"
        )!

        components.queryItems = [
            URLQueryItem(name: "name", value: searchText),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "format", value: "json")
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decodedResponse = try JSONDecoder().decode(
            CitySearchResponse.self,
            from: data
        )

        return decodedResponse.results ?? []
    }
}

