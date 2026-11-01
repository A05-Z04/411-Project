//
//  WeatherCondition.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//

import Foundation

enum WeatherCondition {

    static func description(for code: Int) -> String {
        switch code {
        case 0:
            return "Clear Sky"
        case 1, 2:
            return "Partly Cloudy"
        case 3:
            return "Cloudy"
        case 45, 48:
            return "Foggy"
        case 51...57:
            return "Drizzle"
        case 61...67:
            return "Rainy"
        case 71...77:
            return "Snowy"
        case 80...82:
            return "Rain Showers"
        case 85, 86:
            return "Snow Showers"
        case 95...99:
            return "Thunderstorm"
        default:
            return "Unknown"
        }
    }

    static func icon(for code: Int) -> String {
        switch code {
        case 0:
            return "sun.max.fill"
        case 1, 2:
            return "cloud.sun.fill"
        case 3:
            return "cloud.fill"
        case 45, 48:
            return "cloud.fog.fill"
        case 51...67, 80...82:
            return "cloud.rain.fill"
        case 71...77, 85, 86:
            return "cloud.snow.fill"
        case 95...99:
            return "cloud.bolt.rain.fill"
        default:
            return "cloud"
        }
    }
}

