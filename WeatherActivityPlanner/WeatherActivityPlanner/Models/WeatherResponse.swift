//
//  WeatherRespone.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//

import Foundation

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let current: CurrentWeather
    let daily: DailyWeather
}

struct CurrentWeather: Codable {
    let temperature_2m: Double
    let weather_code: Int
}

struct DailyWeather: Codable {
    let time: [String]
    let weather_code: [Int]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let precipitation_probability_max: [Int]
}

