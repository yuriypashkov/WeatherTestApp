//
//  Extension+View.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation
import SwiftUI

extension View {
    func hSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment )
    }
    
}
