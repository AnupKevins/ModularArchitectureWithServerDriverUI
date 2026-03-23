//
//  AppContainer.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import CoreModule
import FeatureHome
import FeatureProducts

final class AppDependency {
    
    private let apiClient: APIClient
    private let router: AppRouter<AppRoute>
    
    init(environment: AppEnvironment, router: AppRouter<AppRoute>) {
        
        self.apiClient = ApiClientImpl(
            session: .shared,
            baseUrl: environment.baseURL
        )
        
        self.router = router
    }
    // The DependencyContainer should only hold long-lived infrastructure dependencies, not feature objects.
    lazy var homeCoordinator: HomeCoordinator = HomeFeature.makeCoordinator(
        apiClient: apiClient,
        router: router
    )
    
    lazy var productCoordinator: ProductCoordinator = ProductFeature.makeCoordinator(
        apiClient: apiClient,
        router: router
    )
    
    lazy var appCoordinator: AppCoordinator = {
        
        let homeResolver = HomeResolver(coordinator: homeCoordinator)
        let productResolver = ProductResolver(productCoordinator: productCoordinator)
        
        return AppCoordinatorImpl(resolver: [
            homeResolver,
            productResolver
        ])
    }()
}
