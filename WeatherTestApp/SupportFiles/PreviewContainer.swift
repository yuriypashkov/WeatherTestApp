//
//  PreviewContainer.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: FavoriteCity.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        for city in Samples.contents {
            container.mainContext.insert(city)
        }
        return container
    } catch {
        fatalError("Fatal error with preview container")
    }
}()
