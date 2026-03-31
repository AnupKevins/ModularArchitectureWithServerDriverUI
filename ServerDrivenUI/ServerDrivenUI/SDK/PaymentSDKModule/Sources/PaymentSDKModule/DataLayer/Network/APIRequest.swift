//
//  APIRequest.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: String { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    
    func makeURLRequest(baseURL: URL) throws -> URLRequest
}

extension APIRequest {
    
    func makeURLRequest(baseURL: URL) throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
}
