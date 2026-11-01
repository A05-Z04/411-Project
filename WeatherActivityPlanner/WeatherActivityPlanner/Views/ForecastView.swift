//
//  ForecastView.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//

import SwiftUI

struct ForecastView: View {

    @StateObject private var viewModel = ForecastViewModel()

    var cityName: String = "Fullerton"
    var latitude: Double = 33.87
    var longitude: Double = -117.92

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading weather...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else if let weather = viewModel.weather {
                    forecastContent(weather)

                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "cloud.slash")
                            .font(.largeTitle)

                        Text("Weather Unavailable")
                            .font(.title2)
                            .bold()

                        Text(error)
                            .multilineTextAlignment(.center)

                        Button("Try Again") {
                            Task {
                                await loadWeather()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()

                } else {
                    VStack(spacing: 12) {
                        Text("Weather Forecast")
                            .font(.title2)

                        Button("Load Weather") {
                            Task {
                                await loadWeather()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Forecast")
        }
        .task {
            await loadWeather()
        }
    }

    func forecastContent(_ weather: WeatherResponse) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .center, spacing: 10) {
                    Text(cityName)
                        .font(.title2)
                        .fontWeight(.medium)

                    Image(systemName: WeatherCondition.icon(for: weather.current.weather_code))
                        .font(.system(size: 55))
                        .foregroundStyle(.orange)

                    Text("\(Int(weather.current.temperature_2m.rounded()))°")
                        .font(.system(size: 72, weight: .light))

                    Text(WeatherCondition.description(for: weather.current.weather_code))
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 25)

                Text("7-Day Forecast")
                    .font(.title2)
                    .bold()

                VStack(spacing: 0) {
                    ForEach(weather.daily.time.indices, id: \.self) { index in

                        HStack(spacing: 12) {
                            Text(formattedDate(weather.daily.time[index]))
                                .font(.subheadline)

                            Spacer()

                            Image(systemName: WeatherCondition.icon(for: weather.daily.weather_code[index]))
                                .foregroundStyle(.orange)
                                .frame(width: 30)

                            Text("\(weather.daily.precipitation_probability_max[index])%")
                                .foregroundStyle(.blue)
                                .frame(width: 45)

                            Text("\(Int(weather.daily.temperature_2m_max[index].rounded()))°")
                                .fontWeight(.semibold)

                            Text("\(Int(weather.daily.temperature_2m_min[index].rounded()))°")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 14)

                        if index < weather.daily.time.count - 1 {
                            Divider()
                        }
                    }
                }
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
    
    func formattedDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE, MMM d"

        guard let date = inputFormatter.date(from: dateString) else {
            return dateString
        }

        return outputFormatter.string(from: date)
    }
    func loadWeather() async {
        await viewModel.loadWeather(
            latitude: latitude,
            longitude: longitude
        )
    }
}

#Preview {
    ForecastView()
}
