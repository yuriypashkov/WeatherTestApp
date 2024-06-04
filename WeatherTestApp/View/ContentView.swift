//
//  ContentView.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            WeatherDataView()
                .tabItem {
                    Label("Main", systemImage: "location")
                }
            FavoritesListView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    ContentView()
}
