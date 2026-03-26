//
//  MemoryCache.swift
//  CoreModule
//
//  Created by Anup Sahu on 26/03/26.
//

import Foundation

public final class MemoryCache<Key: Hashable, Value>: CacheProtocol {
    
    private let cache = NSCache<CacheKey<Key>, Entry<Value>>()
    
    public init() {}
    
    public func value(for key: Key) -> Value? {
        cache.object(forKey: CacheKey(key))?.value
    }
    
    public func insert(_ value: Value, for key: Key) {
        cache.setObject(Entry(value), forKey: CacheKey(key))
    }
    
    public func remove(for key: Key) {
        cache.removeObject(forKey: CacheKey(key))
    }
    
    public func removeAll() {
        cache.removeAllObjects()
    }

}


