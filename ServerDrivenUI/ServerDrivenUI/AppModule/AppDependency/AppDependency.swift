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
import PaymentSDKWithUIForPaymentSelection

final class AppDependency {
    
    private let apiClient: APIClient
    private let router: AppRouter<AppRoute>
    let imageLoader: ImageLoader
    private let cache: MemoryCache<URL, UIImage>
    private let environment: AppEnvironment
    
    // 🔥 Lazy Payment SDK Creation
    private lazy var paymentSDK: PaymentSDK = {
        PaymentSDKBuilder(
            baseURL: environment.baseURL
        ).registerMethod(type: "WALLET")
            .build()
    }()
    
    private lazy var paymentSDKBuilderWithPaymentUI: PaymentSDKWithUI = {
        PaymentSDKBuilderWithPaymentUI(
            baseURL: environment.baseURL
        ).setUserProvider(UserProviderImpl(userId: "12345"))
            .setPresenter(PaymentPresenterImpl())
            .build()
    }()
    
    private lazy var paymentService: PaymentService = {
        PaymentServiceImpl(
            paymentSDK: paymentSDK
        )
    }()
    
    private lazy var paymentUIService: PaymentUIService = {
        PaymentUIServiceImpl(
            paymentSDK: paymentSDKBuilderWithPaymentUI
        )
    }()
    
    init(
        environment: AppEnvironment,
        router: AppRouter<AppRoute>,
    ) {
        self.environment = environment
        
        self.apiClient = ApiClientImpl(
            session: .shared,
            baseUrl: environment.baseURL
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
        HomeFeature.registerResolver(
            apiClient: apiClient,
            paymentService: paymentService,
            paymentUIService: paymentUIService
        )
        
        ProductFeature.registerResolver(apiClient: apiClient)
        
        VoiceOverFeature.registerResolver()
    }
}
