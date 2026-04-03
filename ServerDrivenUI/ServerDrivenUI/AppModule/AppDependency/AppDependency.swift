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
import FeatureVoiceOver
import UIKit
import PaymentSDKModule

final class AppDependency {
    
    private let apiClient: APIClient
    private let router: AppRouter<AppRoute>
    let imageLoader: ImageLoader
    private let cache: MemoryCache<URL, UIImage>
    private let paymentService: PaymentService
    
    init(
        environment: AppEnvironment,
        router: AppRouter<AppRoute>,
    ) {
        
        self.apiClient = ApiClientImpl(
            session: .shared,
            baseUrl: environment.baseURL
        )
        
        // 🔥 Payment SDK Creation
        let paymentSDK = PaymentSDKBuilder(
            baseURL: environment.baseURL
        ).build()
        
        self.paymentService = PaymentServiceImpl(
            paymentSDK: paymentSDK
        )
        
        self.router = router
        
        self.cache = MemoryCache<URL, UIImage>()
        
        self.imageLoader = ImageLoaderImpl(cache: cache, apiClient: apiClient)
        
        registerFeatureResolvers()
    }
    
    lazy var appCoordinator: AppCoordinator = {
        return AppCoordinatorImpl()
    }()
    
    private func registerFeatureResolvers() {
        HomeFeature.registerResolver(apiClient: apiClient, paymentService: paymentService)
        
        ProductFeature.registerResolver(apiClient: apiClient)
        
        VoiceOverFeature.registerResolver()
    }
}
