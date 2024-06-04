//
//  NetworkService.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    func getWeatheDataByCityName(city: String) async throws -> WeatherData  {
        let _city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.weatherapi.com/v1/current.json?key=" + Constants.apiKey + "&q=" + _city + "&aqi=no"
        
        guard let url = URL(string: urlString) else {
            throw AppError.invalidURL
        }
        
        var data: Data
        var response: URLResponse
        
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw AppError.requestReturnNoData
        }
        
        guard let response = response as? HTTPURLResponse else {
            throw AppError.invalidResponse
        }
        
        print(response.statusCode)
        
        guard response.statusCode == 200 else {
            throw AppError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let value = try decoder.decode(WeatherData.self, from: data)
            return value
        } catch {
            throw AppError.JSONDecodingError
        }
    }
}
