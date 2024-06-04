//
//  FavoritesView.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import SwiftUI
import SwiftData

struct FavoritesListView: View {
    
    @Query private var items: [FavoriteCity]
    
    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    Text("Favorites list is empty")
                } else {
                    List(items) { item in
                        NavigationLink {
                            FavoriteCityView(cityName: item.name)
                        } label: {
                            Text(item.name)
                        }
                    }
                }
            }
            .navigationTitle("Favorites cities")
        }
    }
}

#Preview {
    FavoritesListView()
        .modelContainer(previewContainer)
}
