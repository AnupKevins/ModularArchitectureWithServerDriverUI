//
//  Resolver.swift
//  CoreModule
//
//  Created by Anup Sahu on 23/03/26.
//

import SwiftUI

@MainActor
public protocol Resolver {
    
    associatedtype Route: Hashable
    
    func resolve(route: Route) -> AnyView?
}
