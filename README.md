# Weather Activity Planner

## About the Project

Weather Activity Planner is an iOS application we're developing for our CPSC 411 class at Cal State Fullerton. The goal is to make it easier to plan activities while keeping the weather in mind.

Instead of switching between a weather app and a calendar, users will be able to check the forecast and manage their activities in one place. They'll also be able to search for different cities and save their favorites.

## Planned Features

- Search for cities and check their weather
- View current weather conditions and a 7-day forecast
- Add, edit, and delete planned activities
- Save favorite cities for quick access
- View scheduled activities alongside the forecast
- See when the weather might affect an upcoming activity

## Tools and Technologies

- **Swift** – Main programming language
- **SwiftUI** – User interface
- **Xcode** – Development environment
- **Open-Meteo API** – Weather forecasts and city search
- **SwiftData** – Saving activities locally
- **GitHub** – Version control and collaboration

## How It Works

The app will use the Open-Meteo API to retrieve weather information. When a user searches for a city, the app will use the city's coordinates to request current weather conditions and the upcoming forecast.

Users will also be able to create activities and assign them to specific dates. We'll use SwiftData to save those activities locally so they can still be accessed after closing the app.

The main goal is to let users see their plans and the weather together so they can decide whether they need to adjust anything.

## Current Progress

**Checkpoint 1**
- Decided on the app idea and main features
- Researched and selected the Open-Meteo API
- Planned the app screens and basic data structure
- Assigned responsibilities to team members

**Checkpoint 2 (In Progress)**
- Setting up the Xcode project and GitHub repository
- Working on the weather API connection
- Building the main app screens
- Preparing to test weather requests and display forecast data

## Team Members

- **Sahil Modi** – Home screen, navigation, and SwiftUI integration
- **Julian Wang** – Weather API integration, weather data models, and forecast screen
- **Adrian Zacapala** – City search and favorite cities

Activity management and local data storage will be divided between the remaining team members as development continues.

## Course

CPSC 411 – iOS Mobile Development

California State University, Fullerton
