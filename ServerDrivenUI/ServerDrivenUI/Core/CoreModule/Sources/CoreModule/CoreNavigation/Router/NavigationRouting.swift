//
//  NavigationRouting.swift
//  CoreModule
//
//  Created by Anup Sahu on 24/03/26.
//

@MainActor
public protocol NavigationRouting {
    
    associatedtype Route: Hashable
    
    func push(route: Route)
    
    func pop()
    
    func popToRoot()
}
