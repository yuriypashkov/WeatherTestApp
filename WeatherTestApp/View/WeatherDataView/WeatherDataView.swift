//
//  HomeView.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import SwiftUI
import SwiftData

struct WeatherDataView: View {
    
    @StateObject var viewModel: WeatherDataViewModel = WeatherDataViewModel()
    
    @State private var findCity: Bool = false
    @State var searchable: String = ""
    
    // SwiftData properties
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteCity]
    
    var body: some View {
        VStack(spacing: 8) {
            // load spinner
            ProgressView()
                .progressViewStyle(.circular)
                .opacity(viewModel.isFetching ? 1 : 0)
            // Weather info
            Text(UserDefaults.defaultCityName.isEmpty ? "Current location" : "Default City")
                .font(.title)
                .foregroundStyle(.gray)
            Text(viewModel.data.name ?? "unknown")
                .font(.title2)
                .foregroundStyle(.black)
                .opacity(viewModel.isFetching ? 0 : 1)
            
            HStack {
                Text((viewModel.data.text ?? "none") + ",")
                    .font(.title)
                Text(String(viewModel.data.temp?.stringValue ?? "0") + "°C")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .opacity(viewModel.isFetching ? 0 : 1)
            
            Text("And feels like \(viewModel.data.tempFeelsLike?.stringValue ?? "0")°C")
                .font(.callout)
                .foregroundStyle(.gray)
                .opacity(viewModel.isFetching ? 0 : 1)
            
            Text("Last updated: \(viewModel.data.lastUpdate ?? "none")")
                .font(.subheadline)
                .foregroundStyle(.gray.opacity(0.6))
                .opacity(viewModel.isFetching ? 0 : 1)
            
            // Buttons
            
            // if already saved to favorite - do not show button AddToFavorites
            if let name = viewModel.data.name, favorites.filter({ $0.name == name }).isEmpty {
                Button(action: {
                    let favoriteCity: FavoriteCity = FavoriteCity(name: name)
                    modelContext.insert(favoriteCity)
                    do {
                        try modelContext.save()
                        print("Success saved to favorite")
                    } catch {
                        print(error)
                    }
                }, label: {
                    Text("Add to favorites")
                })
                .opacity(viewModel.isFetching ? 0 : 1)
            }
            
            // if default city - do not show button SetAsDefault
            if let name = viewModel.data.name, UserDefaults.defaultCityName != name {
                Button {
                    UserDefaults.defaultCityName = name
                    print("Default city is \(UserDefaults.defaultCityName)")
                } label: {
                    Text("Set as default")
                }
                .opacity(viewModel.isFetching ? 0 : 1)
            }

        }
        .hSpacing(.center)
        .vSpacing(.top)
        .padding(.top, 24)
        // search button
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                findCity.toggle()
            }, label: {
                Image(systemName: "magnifyingglass")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 54, height: 54)
                    .background(Color.blue.shadow(.drop(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)), in: .circle)
            })
            .padding(16)
        })
        // show city search view
        .sheet(isPresented: $findCity, content: {
            SearchCityView(searchable: $searchable)
                .presentationDetents([.height(200)])
        })
        // get new weather data when searchbutton tapped on searchview
        .onChange(of: searchable) {
            Task {
                do {
                    try await viewModel.getWeatherData(query: searchable)
                } catch {
                    print(error)
                }
            }
        }
        // update weatherdata every view-appear
        .onAppear {
            Task {
                do {
                    try await viewModel.check()
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
