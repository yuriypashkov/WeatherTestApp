//
//  FavoriteCity.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation
import SwiftData

@Model
class FavoriteCity: Identifiable {
    
    var uuid: UUID = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
