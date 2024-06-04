//
//  FindCityView.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import SwiftUI

struct SearchCityView: View {
    
    @State private var searchText: String = ""
    @Environment(\.dismiss) private var dismiss
    @Binding var searchable: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Enter city name")
            TextField("Enter city name", text: $searchText)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 2)), in: .rect(cornerRadius: 12))
            Button(action: {
                searchable = searchText
                dismiss()
            }, label: {
                Text("Search")
            })
        }
        .vSpacing(.center)
        .padding(8)
    }
}

#Preview {
    WeatherDataView()
}
