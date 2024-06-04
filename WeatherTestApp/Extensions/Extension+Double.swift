//
//  Extension+Double.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation

extension Double {
    var stringValue: String {
        String(format: "%.0f", self)
    }
}
