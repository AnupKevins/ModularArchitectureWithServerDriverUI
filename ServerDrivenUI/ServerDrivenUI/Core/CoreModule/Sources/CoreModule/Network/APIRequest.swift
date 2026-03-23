//
//  Endpoint.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/03/26.
//

import Foundation

public protocol APIRequest {
    associatedtype Response: Decodable
    
    var path : String { get }
    var httpMethod: HttpMethod { get }
    
    var queryItems: [URLQueryItem]? { get }
    
}

public extension APIRequest {
    var queryItems: [URLQueryItem]? { nil }
    
    func makeURLRequest(baseURL: URL) throws -> URLRequest {
        
        let urlComponents = URLComponents(
            url: baseURL.appending(component: path),
            resolvingAgainstBaseURL: false
        )
        
        guard let url = urlComponents?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
}

//public actor Endpoint {
//    let method: String
//    let path: String
//    let queryItems: [URLQueryItem]?
//    
//    public init(method: String, path: String, queryItems: [URLQueryItem]? = nil) {
//        self.method = method
//        self.path = path
//        self.queryItems = queryItems
//    }
//}
