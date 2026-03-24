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

@MainActor
protocol AppCoordinator {
   
    func start(route: AppRoute) -> AnyView
}

final class AppCoordinatorImpl: AppCoordinator {
    
    // Use Dictionary to reduce the TC from for loop O(n) to O(1)
    
    init() {
        // 🔥 Register once here
        ServerDrivenEngineViewRegister.registerDefaults()
    }
    
    func start(route: AppRoute) -> AnyView {
        resolve(route.featureRoute, notFound: "Route not found")
    }
    
    private func resolve(_ route: any Hashable, notFound message: String) -> AnyView {
        ResolverRegistry.shared.resolve(route: route)
        ?? AnyView(Text(message))
    }
}
