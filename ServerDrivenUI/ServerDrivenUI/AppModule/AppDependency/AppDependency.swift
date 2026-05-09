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
    /// For PaymentSDKModule WithoutUI
    private lazy var paymentSDK: PaymentSDK = {
        PaymentSDKBuilder(
            baseURL: environment.baseURL
        ).registerMethod(type: "WALLET")
            .build()
    }()
    
    /// For PaymentSDKModule WithoutUI
    private lazy var paymentService: PaymentService = {
        PaymentServiceImpl(
            paymentSDK: paymentSDK
        )
    }()
    
    /// For PaymentSDKWithUIForPaymentSelection Provider
    private lazy var paymentMethodsProvider: PaymentMethodsProvider = {
        AppPaymentMethodsProvider(apiClient: apiClient)
    }()
    
    /// For PaymentSDKWithUIForPaymentSelection UI Service
    private lazy var PaymentUIService: PaymentSDKUIService = {
        
        let config = PaymentUIConfig(
            baseURL: environment.baseURL,
            userProvider: UserProviderImpl(userId: "12345"),
            methodsProvider: paymentMethodsProvider
        )
        
        return PaymentSDKFactory.makeUIService(config: config)
    }()
    
    /// 🔥 Adapter (Core Abstration for PaymentSDKWithUIForPaymentSelection)
    /// This allows us to use PaymentUIService as a PaymentUIService in our app, without exposing the entire SDK to the app layer.
    /// IN CORE MODULE
    
    private lazy var paymentUIService: PaymentUIService = {
        PaymentUIServiceAdapter(sdkService: PaymentUIService)
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
