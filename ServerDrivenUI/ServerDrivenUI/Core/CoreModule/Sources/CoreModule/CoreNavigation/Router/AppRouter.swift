//
//  AppRouter.swift
//  CoreModule
//
//  Created by Anup Sahu on 04/03/26.
//

import Observation

@MainActor
@Observable
public final class AppRouter<Route: Hashable>: NavigationRouting {
    
    public var path: [Route] = []
    
    public init() {}
    
    public func push(route: Route) {
        path.append(route)
    }
    
    public func pop() {
       guard !path.isEmpty else { return }
        
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeAll()
    }
    
    // Replace the top screen
    public func replace(_ route: Route) {
        guard !path.isEmpty else {
            path.append(route)
            return
        }
        
        path.removeLast()
        path.append(route)
    }
    
    // Reset stack with new routes (deep link)
    public func reset(_ routes: [Route]) {
        path = routes
    }
}

