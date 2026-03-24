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

public enum AppRoute: Hashable {
    case homeRoute(ServerDrivenHomeRoute)
    case productListRoute(ProductRoute)
}

final class AppDependency {
    
    private let apiClient: APIClient
    private let router: AppRouter<AppRoute>
    
    init(environment: AppEnvironment, router: AppRouter<AppRoute>) {
        
        self.apiClient = ApiClientImpl(
            session: .shared,
            baseUrl: environment.baseURL
        )
        
        self.router = router
        
        registerFeatureResolvers()
    }
    
    lazy var appCoordinator: AppCoordinator = {
        return AppCoordinatorImpl()
    }()
    
    private func registerFeatureResolvers() {
        HomeFeature.registerResolver(apiClient: apiClient)
        
        ProductFeature.registerResolver(apiClient: apiClient)
    }
}
