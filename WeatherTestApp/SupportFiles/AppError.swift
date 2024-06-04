//
//  AppError.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation

enum AppError: Error {
    
    case unknownError
    case requestReturnNoData
    case someError(String)
    case noItemsInResponse
    case JSONDecodingError
    case invalidURL
    case invalidResponse
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .requestReturnNoData:
            return NSLocalizedString("Request return no data", comment: "")
        case .someError(let errorDescription):
            return NSLocalizedString(errorDescription, comment: "")
        case .noItemsInResponse:
            return NSLocalizedString("No items in response", comment: "")
        case .JSONDecodingError:
            return NSLocalizedString("Error with JSON decoding", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid Response", comment: "")
        }
    }
}
