//
//  NetworkClient.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

import Foundation

protocol NetworkClient: Sendable {
    func request<R: APIRequest>(_ request: R) async throws -> R.Response
}

final class NetworkClientImpl: NetworkClient {

    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder
    private let interceptors: [RequestInterceptor]
    
    init(
        session: URLSession = .shared,
        baseURL: URL,
        decoder: JSONDecoder,
        interceptors: [RequestInterceptor]
    ) {
        self.session = session
        self.baseURL = baseURL
        self.decoder = decoder
        self.interceptors = interceptors
    }
    
    func request<R: APIRequest>(_ request: R) async throws -> R.Response {
        
        var urlRequest = try request.makeURLRequest(baseURL: baseURL)
        
        // Apply Interceptors to add token
        for interceptor in interceptors {
            try await interceptor.intercept(&urlRequest)
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(R.Response.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
        
    }
}
