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
import FeatureHome
import FeatureProducts

@MainActor
protocol AppCoordinator {
   
    func start(route: AppRoute) -> AnyView
}

final class AppCoordinatorImpl: AppCoordinator {
    
    // Use Dictionary to reduce the TC from for loop O(n) to O(1)
    private let homeResolver: HomeResolver
    private let productResolver: ProductResolver
    
    init(
        homeResolver: HomeResolver,
        productResolver: ProductResolver
    ) {
        self.homeResolver = homeResolver
        self.productResolver = productResolver
        
        // 🔥 Register once here
        ServerDrivenEngineViewRegister.registerDefaults()
    }
    
    func start(route: AppRoute) -> AnyView {
        
        switch route {
            case .homeRoute(let serverDrivenHomeRoute):
                
                return homeResolver.resolve(route: serverDrivenHomeRoute) ?? AnyView(Text("Home route not found"))
            case .productListRoute(let productRoute):
                
                return productResolver.resolve(route: productRoute) ?? AnyView(Text("Product route not found"))
        }
    }
}
