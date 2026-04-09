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
    private let interceptors: [RequestAuthInterceptor]
    private let retryExecutor: RetryExecutor?
    
    init(
        session: URLSession = .shared,
        baseURL: URL,
        decoder: JSONDecoder = JSONDecoder(),
        interceptors: [RequestAuthInterceptor],
        retryPolicy: RetryPolicy? = nil
    ) {
        self.session = session
        self.baseURL = baseURL
        self.decoder = decoder
        self.interceptors = interceptors
        
        if let retryPolicy = retryPolicy {
            retryExecutor = RetryExecutorImpl(policy: retryPolicy)
        } else {
            retryExecutor = nil
        }
    }
    
    func request<R: APIRequest>(_ request: R) async throws -> R.Response {
        
        let closureTask = {
            try await self.performRequest(request) // 3
        }
        
        if let retryExecutor = retryExecutor {
            return try await retryExecutor.execute(closureTask) // 1
        } else {
            return try await closureTask()
        }
    }
    
    private func performRequest<R: APIRequest>(_ request: R) async throws -> R.Response {
        
        var urlRequest = try request.makeURLRequest(baseURL: baseURL)
        
        // Apply Interceptors to add token
        for interceptor in interceptors {
            try await interceptor.intercept(&urlRequest)
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        print("@@@ url request", urlRequest)
        print("@@@ response", response)
        
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
