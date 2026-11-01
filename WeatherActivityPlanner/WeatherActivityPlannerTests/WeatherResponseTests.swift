//
//  WeatherResponseTests.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//

import XCTest
@testable import WeatherActivityPlanner

final class WeatherResponseTests: XCTestCase {

    func testWeatherResponseDecoding() throws {

        let json = """
        {
            "latitude": 33.87,
            "longitude": -117.92,
            "current": {
                "temperature_2m": 72.5,
                "weather_code": 1
            },
            "daily": {
                "time": ["2026-10-31", "2026-11-01"],
                "weather_code": [1, 61],
                "temperature_2m_max": [78.0, 70.0],
                "temperature_2m_min": [60.0, 55.0],
                "precipitation_probability_max": [10, 80]
            }
        }
        """

        let data = Data(json.utf8)
        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

        XCTAssertEqual(weather.latitude, 33.87)
        XCTAssertEqual(weather.longitude, -117.92)

        XCTAssertEqual(weather.current.temperature_2m, 72.5)
        XCTAssertEqual(weather.current.weather_code, 1)

        XCTAssertEqual(weather.daily.time.count, 2)
        XCTAssertEqual(weather.daily.time[0], "2026-10-31")
        XCTAssertEqual(weather.daily.weather_code[1], 61)

        XCTAssertEqual(weather.daily.temperature_2m_max[0], 78.0)
        XCTAssertEqual(weather.daily.temperature_2m_min[1], 55.0)
        XCTAssertEqual(weather.daily.precipitation_probability_max[1], 80)
    }
}
