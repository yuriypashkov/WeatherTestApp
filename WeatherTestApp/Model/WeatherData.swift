//
//  WeatherData.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation

struct WeatherData: Decodable {
    
    var temp: Double?
    var tempFeelsLike: Double?
    var lastUpdate: String?
    var name: String?
    var text: String?
    
    enum CodingKeys: String, CodingKey {
        // containers
        case current
        case location
        case condition
        // data
        case temp = "temp_c"
        case tempFeelsLike = "feelslike_c"
        case lastUpdate = "last_updated"
        case name
        case text
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let currentContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .current)
        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        let conditionContainer = try currentContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .condition)
        
        self.lastUpdate = try? currentContainer.decode(String.self, forKey: .lastUpdate)
        self.temp = try? currentContainer.decode(Double.self, forKey: .temp)
        self.tempFeelsLike = try? currentContainer.decode(Double.self, forKey: .tempFeelsLike)
        self.name = try? locationContainer.decode(String.self, forKey: .name)
        self.text = try? conditionContainer.decode(String.self, forKey: .text)
    }

    init() {
        self.lastUpdate = nil
        self.name = nil
        self.temp = nil
        self.tempFeelsLike = nil
        self.text = nil
    }
}
