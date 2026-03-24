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
    
    // RouteType -> Resolver and Dictionary reduces the timr complexity from O(n) to O(1)
    private var resolvers: [ObjectIdentifier: (any Hashable) -> AnyView?] = [:]
    
    private init() {}
    
    public func register<Route: Hashable>(
        routeType: Route.Type,
        resolver: @escaping (Route) -> AnyView?
    ) {
        resolvers[ObjectIdentifier(routeType)] = { route in
            guard let typedRoute = route as? Route else {
                return nil
            }
            
            return resolver(typedRoute)
        }
    }
    
    // inside closure runs only when you call this resolve
    public func resolve(route: any Hashable) -> AnyView? {
        
        let key = ObjectIdentifier(type(of: route))
        return resolvers[key]?(route)
    }
}
