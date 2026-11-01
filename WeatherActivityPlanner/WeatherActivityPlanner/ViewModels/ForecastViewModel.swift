//
//  ForecastViewModel.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//

import Foundation
import Combine

@MainActor
class ForecastViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService = WeatherService()

    func loadWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil

        do {
            weather = try await weatherService.fetchWeather(
                latitude: latitude,
                longitude: longitude
            )
        } catch {
            errorMessage = "Could not load weather data. Please try again."
        }

        isLoading = false
    }
}
