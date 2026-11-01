//
//  WeatherService.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//


import Foundation

class WeatherService {

    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {

        var urlComponents = URLComponents(string: "https://api.open-meteo.com/v1/forecast")!

        urlComponents.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,weather_code"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max"),
            URLQueryItem(name: "temperature_unit", value: "fahrenheit"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "7")
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return weather
    }
}
