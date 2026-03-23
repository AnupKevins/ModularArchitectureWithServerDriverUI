//
//  AppCoordinator.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import SwiftUI
import CoreModule
import ServerDrivenEngine

protocol AppCoordinator {
   
    func start(route: AppRoute) -> AnyView
}

final class AppCoordinatorImpl: AppCoordinator {
    
    // Use Dictionary to reduce the TC from for loop O(n) to O(1)
    private let resolvers: [AppRoute: Resolver]
    init(
        resolvers: [AppRoute: Resolver]
    ) {
        self.resolvers = resolvers
        // 🔥 Register once here
        ServerDrivenEngineViewRegister.registerDefaults()
    }
    
    func start(route: AppRoute) -> AnyView {
        
        if let resolver = resolvers[route] {
            if let view = resolver.resolve(route: route) {
                return view
            }
        }
        
        return AnyView(Text("No View for this route"))
    }
}
