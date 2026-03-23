//
//  AppRouter.swift
//  CoreModule
//
//  Created by Anup Sahu on 04/03/26.
//

import Observation

@Observable
public final class AppRouter<Route: Hashable> {
    
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
}

