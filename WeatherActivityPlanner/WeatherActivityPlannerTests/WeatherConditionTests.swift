//
//  WeatherConditionTests.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//

import XCTest
@testable import WeatherActivityPlanner

final class WeatherConditionTests: XCTestCase {

    func testClearSky() {
        XCTAssertEqual(WeatherCondition.description(for: 0), "Clear Sky")
        XCTAssertEqual(WeatherCondition.icon(for: 0), "sun.max.fill")
    }

    func testRain() {
        XCTAssertEqual(WeatherCondition.description(for: 61), "Rainy")
        XCTAssertEqual(WeatherCondition.icon(for: 61), "cloud.rain.fill")
    }

    func testThunderstorm() {
        XCTAssertEqual(WeatherCondition.description(for: 95), "Thunderstorm")
        XCTAssertEqual(WeatherCondition.icon(for: 95), "cloud.bolt.rain.fill")
    }

    func testUnknownWeather() {
        XCTAssertEqual(WeatherCondition.description(for: 999), "Unknown")
        XCTAssertEqual(WeatherCondition.icon(for: 999), "cloud")
    }
}
