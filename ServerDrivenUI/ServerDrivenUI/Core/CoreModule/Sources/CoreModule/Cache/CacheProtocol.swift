//
//  CacheType.swift
//  CoreModule
//
//  Created by Anup Sahu on 26/03/26.
//

public protocol CacheProtocol {
    associatedtype Key: Hashable
    associatedtype Value
    
    func value(for key: Key) -> Value?
    func insert(_ value: Value, for key: Key)
    func remove(for key: Key)
    func removeAll()
}
