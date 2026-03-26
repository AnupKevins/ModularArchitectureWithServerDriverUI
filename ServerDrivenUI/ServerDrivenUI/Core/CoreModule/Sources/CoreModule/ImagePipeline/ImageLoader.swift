//
//  ImageLoader.swift
//  CoreModule
//
//  Created by Anup Sahu on 26/03/26.
//

import Foundation
import UIKit

//Without task tracking:
//
//Cell1 → download A
//Cell2 → download A
//Cell3 → download A
// 3 network call same url

//With task tracking:
//
//Cell1 → create Task(A)
//Cell2 → await Task(A)
//Cell3 → await Task(A)
//
//Only one network call.

public protocol ImageLoader: Sendable {
    func loadImage(from url: URL) async throws -> UIImage
}

public actor ImageLoaderImpl<Cache: CacheProtocol>: ImageLoader
    where Cache.Key == URL, Cache.Value == UIImage {
    
    private let cache: Cache
    private let apiClient: APIClient
    
    private var runningTask: [URL: Task<UIImage, Error>] = [:]
    
    public init(cache: Cache, apiClient: APIClient) {
        self.cache = cache
        self.apiClient = apiClient
    }
    
    public func loadImage(from url: URL) async throws -> UIImage {
        
        if let cached = cache.value(for: url) {
            return cached
        }
        
        if let existingTask = runningTask[url] {
            return try await existingTask.value
        }
        
        let task = Task<UIImage, Error> {
            
            defer { runningTask[url] = nil }
            
            let data = try await self.apiClient.data(from: url)
            
            guard let image = UIImage(data: data) else {
                throw URLError(.cannotDecodeContentData)
            }
            
            cache.insert(image, for: url)
            
            return image
        }
        
        runningTask[url] = task
        
        return try await task.value
        
    }
    
    
}
