//
//  NetworkError.swift
//  CoreModule
//
//  Created by Anup Sahu on 20/03/26.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed(Error)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidResponse:
                return "Invalid Response"
            case .invalidStatusCode(let code):
                return "Invalid Status Code: \(code)"
            case .decodingFailed(let error):
                return "Decoding Failed: \(error.localizedDescription)"
        }
    }
}
