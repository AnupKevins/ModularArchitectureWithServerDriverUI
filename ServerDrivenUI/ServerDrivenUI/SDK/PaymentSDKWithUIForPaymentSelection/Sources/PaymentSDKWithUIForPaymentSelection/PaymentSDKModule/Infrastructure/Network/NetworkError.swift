//
//  NetworkError.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

enum NetworkError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed(Error)
}
