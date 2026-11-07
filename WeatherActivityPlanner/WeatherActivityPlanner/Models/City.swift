import Foundation

struct City: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let admin1: String?

    var displayName: String {
        if let admin1 = admin1, !admin1.isEmpty {
            return "\(name), \(admin1), \(country)"
        }

        return "\(name), \(country)"
    }
}

struct CitySearchResponse: Codable {
    let results: [City]?
}
