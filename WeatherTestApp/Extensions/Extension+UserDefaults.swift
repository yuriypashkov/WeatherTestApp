//
//  Extension+UserDefaults.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let defaultCityName = "keyDefaultCityName"
    }
    
    static var defaultCityName: String {
        get { UserDefaults.standard.string(forKey: Keys.defaultCityName) ?? "" }
        set (newValue) { UserDefaults.standard.setValue(newValue, forKey: Keys.defaultCityName) }
    }
}
