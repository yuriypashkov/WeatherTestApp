//
//  WeatherDataViewModel.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation

class WeatherDataViewModel: ObservableObject {
    
    @Published var data: WeatherData = .init()
    @Published var isFetching: Bool = false
    
    private var locationManager = LocationManager()
    
    init() {
        // observe auth status
        locationManager.delegate = self
    }
    
    @MainActor
    func getWeatherData(query: String) async throws {
        isFetching = true
        do {
            data = try await NetworkService.shared.getWeatheDataByCityName(city: query)
        } catch {
            print(error)
        }
        isFetching = false
    }
    
    @MainActor
    func check() async throws {
        do {
            if !UserDefaults.defaultCityName.isEmpty {
                // have saved city
                let query = UserDefaults.defaultCityName
                try await getWeatherData(query: query)
            } else {
                // doesn't have saved city, try use location
                if let location = locationManager.lastLocation {
                    let query = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
                    try await getWeatherData(query: query)
                } else {
                    print("Doesn't have coordinates") // do nothing or send mock-value maybe
                }
            }
        } catch {
            print(error)
        }
    }
}

extension WeatherDataViewModel: LocationManagerDelegate {
    @MainActor
    func locationDidUpdate() {
        Task {
            do {
                try await check()
            } catch {
                print(error)
            }
        }
    }
}
