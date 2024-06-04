//
//  FavoriteCityView.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import SwiftUI

struct FavoriteCityView: View {
    
    @State var currentData: WeatherData = .init()
    @State var isFetching: Bool = false
    @State var cityName: String
    
    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
                .progressViewStyle(.circular)
                .opacity(isFetching ? 1 : 0)
            // Weather info
            Text("Favorite location")
                .font(.title)
                .foregroundStyle(.gray)
            Text(currentData.name ?? "unknown")
                .font(.title2)
                .foregroundStyle(.black)
                .opacity(isFetching ? 0 : 1)
            
            HStack {
                Text((currentData.text ?? "none") + ",")
                    .font(.title)
                Text(String(currentData.temp?.stringValue ?? "0") + "°C")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .opacity(isFetching ? 0 : 1)
            
            Text("And feels like \(currentData.tempFeelsLike?.stringValue ?? "0")°C")
                .font(.callout)
                .foregroundStyle(.gray)
                .opacity(isFetching ? 0 : 1)
            
            Text("Last updated: \(currentData.lastUpdate ?? "none")")
                .font(.subheadline)
                .foregroundStyle(.gray.opacity(0.6))
                .opacity(isFetching ? 0 : 1)
            
            // button
            if UserDefaults.defaultCityName != cityName {
                Button {
                    UserDefaults.defaultCityName = cityName
                    print("Default city is \(UserDefaults.defaultCityName)")
                } label: {
                    Text("Set as default")
                }
                .opacity(isFetching ? 0 : 1)
            }
            
            //                Button {
            //                    do {
            //                        try modelContext.delete(model: FavoriteCity.self)
            //                    } catch {
            //                        print(error)
            //                    }
            //                } label: {
            //                    Text("Remove all data")
            //                }
        }
        .hSpacing(.center)
        .vSpacing(.top)
        .padding(.top, 24)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            Task {
                do {
                    isFetching = true
                    currentData = try await NetworkService.shared.getWeatheDataByCityName(city: cityName)
                    isFetching = false
                } catch {
                    print(error)
                }
            }
        }
    }
}
