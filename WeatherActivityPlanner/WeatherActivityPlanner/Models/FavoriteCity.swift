import Foundation
import SwiftData

@Model
final class FavoriteCity {

    @Attribute(.unique)
    var cityID: Int

    var name: String
    var latitude: Double
    var longitude: Double
    var country: String
    var admin1: String?

    init(
        cityID: Int,
        name: String,
        latitude: Double,
        longitude: Double,
        country: String,
        admin1: String?
    ) {
        self.cityID = cityID
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.country = country
        self.admin1 = admin1
    }

    convenience init(city: City) {
        self.init(
            cityID: city.id,
            name: city.name,
            latitude: city.latitude,
            longitude: city.longitude,
            country: city.country,
            admin1: city.admin1
        )
    }

    var displayName: String {
        if let admin1 = admin1, !admin1.isEmpty {
            return "\(name), \(admin1), \(country)"
        }

        return "\(name), \(country)"
    }
}
