//
//  WeatherActivityPlannerApp.swift
//  WeatherActivityPlanner
//
//  Created by Julian wang on 10/31/26.
//  Editted by Adrian on 11/03/26


import SwiftUI
import SwiftData

@main
struct WeatherActivityPlannerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FavoriteCity.self)
    }
}
