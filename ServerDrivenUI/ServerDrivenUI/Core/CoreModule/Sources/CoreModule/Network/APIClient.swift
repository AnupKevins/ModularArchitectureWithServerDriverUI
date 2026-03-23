// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public protocol APIClient {
    func request<R: APIRequest>(_ request: R) async throws -> R.Response
}

public final class ApiClientImpl: APIClient {
    
    private let session: URLSession
    private let baseUrl: URL
    private let decoder: JSONDecoder
    
    public init(
        session: URLSession,
        baseUrl: URL,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.baseUrl = baseUrl
        self.decoder = decoder
    }
    
    public func request<R: APIRequest>(_ request: R) async throws -> R.Response {
        
        let request = try request.makeURLRequest(baseURL: baseUrl)
        
        let data: Data
        let response: URLResponse
        
        if #available(iOS 15.0, *) {
            (data, response) = try await session.data(for: request)
        } else {
            // Fallback on earlier versions
            (data, response) = try await withCheckedThrowingContinuation { continuation in
                
                session.dataTask(with: request) { data, response, error in
                    
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let data, let response else {
                        continuation.resume(throwing: NetworkError.invalidResponse)
                        return
                    }
                    
                    continuation.resume(returning: (data, response))
                }.resume()
            }
        }
        
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
    
//    public func fetchPage<T: Codable & Sendable>(_ endpoint: Endpoint) async throws -> T {
//        guard var components = URLComponents(url: baseUrl.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
//            throw URLError(.badURL)
//        }
//        print(components.url!)
//        components.queryItems = endpoint.queryItems
//        
//        var request = URLRequest(url: components.url!)
//        request.httpMethod = endpoint.method
//        
//        // ios 15
//        
//        let (data, response) = try await session.data(for: request)
//        
//        // withCheckedThrowingContinuation for ios 13, use above after ios 15
//        /*let (data, response): (Data, URLResponse) = try await withCheckedThrowingContinuation { continuation in
//            session.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                } else if let data, let response = response {
//                    continuation.resume(returning: (data, response))
//                }
//                
//            }.resume()
//        }*/
//        print("response", response)
//        guard let httpResponse = response as? HTTPURLResponse, (200...200).contains(httpResponse.statusCode) else {
//            
//            throw URLError(.badServerResponse)
//        }
//        let jsonString = String(data: data, encoding: .utf8)
//        print("jsonString", jsonString ?? "")
//        // Decode
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    }
}
