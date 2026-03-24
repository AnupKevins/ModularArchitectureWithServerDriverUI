//
//  ResolveRegistry.swift
//  CoreModule
//
//  Created by Anup Sahu on 24/03/26.
//

import SwiftUI

@MainActor
public final class ResolverRegistry {
    
    public static let shared = ResolverRegistry()
    
    private var resolvers: [(any Hashable) -> AnyView?] = []
    
    private init() {}
    
    public func register(_ resolver: @escaping (any Hashable) -> AnyView?) {
        resolvers.append(resolver)
    }
    
    // inside closure runs only when you call this resolve
    public func resolve(route: any Hashable) -> AnyView? {
        
        for resolver in resolvers {
            if let view = resolver(route) {
                return view
            }
        }
        
        return nil 
    }
}
